require 'resque/server'

class SecureResqueServer < Resque::Server

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == [ENV['RESQUE_USERNAME'], ENV['RESQUE_PASSWORD']]
  end

end