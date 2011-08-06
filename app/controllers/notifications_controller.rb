require 'rexml/document'
require "messenger"

class NotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    begin
      data = request.body.read
      doc = REXML::Document.new(data)
      
      phone_number = nil 
      message = nil
      doc.elements.each("InboundMessage/From") do |element|
        phone_number = element.text
      end
      doc.elements.each("InboundMessage/MessageText") do |element|
        message = element.text
      end

      raise "No message found" if message.nil?
      raise "No phone number found" if phone_number.nil?
      
      command  = message.strip.upcase
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
