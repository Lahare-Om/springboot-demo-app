require 'sinatra'
require 'json'

set :port, 8080
set :bind, '0.0.0.0'

get '/' do
  content_type :json
  {
    message: 'Hello from Ruby App',
    version: '1.0.0'
  }.to_json
end

get '/health' do
  content_type :json
  hostname = `hostname`.strip
  {
    status: 'healthy',
    hostname: hostname
  }.to_json
end
