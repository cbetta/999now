class Authorisation < ActiveRecord::Base
  attr_accessible :phone_number
  
  validates_format_of :phone_number,
      :message => "must be a valid UK telephone number.",
      :with => /^07[0-9]{9}$/
      
  validates_uniqueness_of :phone_number      
      
  before_validation :convert_number
  before_create :generate_confirmation_code
  
  def convert_number
    self.phone_number = self.phone_number.gsub(/[^0-9]/, "")
  end
  
  def code 
    return nil
  end
  
  def generate_confirmation_code
  end
end
