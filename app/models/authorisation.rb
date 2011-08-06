require "messenger"

class Authorisation < ActiveRecord::Base
  attr_accessible :phone_number, :is_certified
  
  validates_format_of :phone_number,
      :message => "must be a valid UK telephone number.",
      :with => /^07[0-9]{9}$/
      
  validates_uniqueness_of :phone_number  
  validates_acceptance_of :is_certified, :allow_nil=>false, :accept=>true 
      
  before_validation :convert_number
  before_create :generate_confirmation_code
  after_create :send_confirmation_request
  
  def convert_number
    self.phone_number = self.phone_number.gsub(/[^0-9]/, "")
  end
  
  def code 
    return nil
  end

  def generate_confirmation_code
    self.confirmation_code = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), ENV['HMO_SECRET'], self.phone_number+Time.now.to_s).last(5).upcase
  end
  
  def send_confirmation_request
    Messenger.send(self.phone_number, "This is your confirmation code for Help Me Now: #{self.confirmation_code}", true)
  end
end
