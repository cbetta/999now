require 'resque'

class Alarm < ActiveRecord::Base
  attr_accessible :location, :phone_number, :postcode
    
  validates_format_of :phone_number,
      :message => "must be a valid UK telephone number.",
      :with => /^07[0-9]{9}$/
        
  validates_presence_of :postcode

  before_validation :convert_number, :convert_postcode
  after_create :notify_responders
  
  def convert_number
    self.phone_number = self.phone_number.gsub(/[^0-9]/, "")
  end
  
  
  def notify_responders
    Resque.enqueue(Alarm, self.id, "text_responders")
  end
  
  def text_responders
    postcode = UKPostcode.new(self.postcode)
    Authorisation.where(:postcode => postcode.outcode).each do |authorisation|
      Resque.enqueue(Authorisation, authorisation.id, "notify", self.id)
    end
  end
  
  def convert_postcode
    unless self.postcode.blank?
      postcode = UKPostcode.new(self.postcode)
      if !postcode.valid?
        self.postcode = nil
      end
    end
  end
  
  def self.queue
    :alarms
  end
  
  def self.perform(id, method, *args)
    alarm = Alarm.find(id)
    alarm.send(method, *args)
  end
  
  
end
