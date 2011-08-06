require "messenger"
require "uk_postcode"

class Authorisation < ActiveRecord::Base
  attr_accessible :phone_number, :is_certified, :postcode
  
  validates_format_of :phone_number,
      :message => "must be a valid UK telephone number.",
      :with => /^07[0-9]{9}$/
      
  validates_uniqueness_of :phone_number  
  validates_acceptance_of :is_certified, :allow_nil=>false, :accept=>true 
  validates_presence_of :postcode
      
  before_validation :convert_number, :convert_postcode
  before_create :generate_confirmation_code
  after_create :queue_confirmation_request
  
  def self.queue
    :authorisations
  end
  
  def self.perform(id, method, *args)
    authorisation = Authorisation.find(id)
    authorisation.send(method, *args)
  end
  
  def notify(alarm_id)
    alarm = Alarm.find(alarm_id)
    Messenger.send(self.phone_number, "Alarm @ #{alarm.postcode} #{"("+alarm.location+")" unless alarm.location.blank?} - #{alarm.phone_number}")
  end
  
  def convert_number
    self.phone_number = self.phone_number.gsub(/[^0-9]/, "")
  end
  
  def convert_postcode
    unless self.postcode.blank?
      postcode = UKPostcode.new(self.postcode)
      if postcode.valid?
        self.postcode =  postcode.outcode
      else
        self.postcode = nil
      end
    end
  end
  
  def code 
    return nil
  end

  def generate_confirmation_code
    self.confirmation_code ||= OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), ENV['HMO_SECRET'], self.phone_number+Time.now.to_s).last(5).upcase
  end
  
  def queue_confirmation_request
    Resque.enqueue(Authorisation, self.id, "send_notification_request")
  end
  
  def send_notification_request
    Messenger.send(self.phone_number, "This is your confirmation code for Help Me Now: #{self.confirmation_code}", true)
  end
end
