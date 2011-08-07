require "messenger"

class NotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    begin
      phone_number = params[:InboundMessage][:From]
      message = params[:InboundMessage][:MessageText]
      
      raise "No message found" if message.blank?
      raise "No phone number found" if phone_number.blank?
      
      command  = message.strip.upcase
      phone_number.gsub(/^44/, '0')
      if command == "STOP"
        authorisation = Authorisation.find_by_phone_number(phone_number)
        authorisation.destroy
        Messenger.send(phone_number, "You have now been unsubscribed from 999now.", true)
      end
    
      render :xml => {:response => {:state => 'success'}}
    rescue
      render :xml => {:response => {:state => 'error'}}
    end
  end

end
