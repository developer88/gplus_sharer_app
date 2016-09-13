# myapp.rb
require 'sinatra'
require 'sucker_punch'
require_relative './jobs/share_job'

post '/' do
  ShareJob.perform_async(params) if authorised?
end

get '/' do
  "Queues: " + SuckerPunch::Queue.all.inspect if authorised?
end

get '/debug/screenshot' do
  file = Dir.glob("/app/./*.*").map{|f| f.split('/').last}.select{|filename| filename.include?('png') }.last
  send_file "/app/./#{file}", :filename => file, :type => 'Application/octet-stream'
end

def authorised?
  (ENV['SECRET_CODE'] && ENV['SECRET_CODE'] == params['secret'])
end
