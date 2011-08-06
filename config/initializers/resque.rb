require 'resque'

ENV["REDISTOGO_URL"] ||= "redis://127.0.0.1:6379"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

Resque.after_fork do |job|
 ActiveRecord::Base.connection.reconnect!
end
