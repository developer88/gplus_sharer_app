# myapp.rb
require 'sinatra'
require 'sucker_punch'
require 'logger'

require_relative './log4heroku'
require_relative './jobs/share_job'

post '/' do
  if authorised?
    ShareJob.perform_async(params)
  end
end

get '/' do
  if authorised?
    "Queues: " + SuckerPunch::Queue.all.inspect
  end
end

get '/debug/screenshot' do
  file = Dir.glob("/app/./*.*").map{|f| f.split('/').last}.select{|filename| filename.include?('png') }.last
  send_file "/app/./#{file}", :filename => file, :type => 'Application/octet-stream'
end

def authorised?
  (ENV['SECRET_CODE'] && ENV['SECRET_CODE'] == params['secret'])
end
