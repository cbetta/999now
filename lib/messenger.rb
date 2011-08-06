class Messenger
  def self.send(phone_nr, message, no_footer=false)
    account = Esendex::Account.new(ENV['HMN_ESENDEX_ACCOUNT_NR'], ENV['HMN_ESENDEX_EMAIL'], ENV['HMN_ESENDEX_PASSWORD']) 
    message = Esendex::Message.new(phone_nr, message)
    message.from = "HelpMeNow"
    message.body += " - Reply with STOP to stop these messages" unless no_footer
    batch_id = account.send_message(message)
  end
end