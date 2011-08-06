class Authorisation < ActiveRecord::Base
  attr_accessible :phone_number
  
  validates_format_of :phone_number,
      :message => "must be a valid UK telephone number.",
      :with => /^07[0-9]{9}$/
      
      
  before_validation :convert_number
  
  def convert_number
    self.phone_number = self.phone_number.gsub(/[^0-9]/, "")
  end
  
  def code 
    ""
  end
end
