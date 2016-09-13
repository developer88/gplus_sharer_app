# myapp.rb
require 'sinatra'
require 'sucker_punch'
require_relative './jobs/share_job'

require "logger"

configure do
  LOG = Logger.new(STDOUT)
  LOG.level = Logger.const_get ENV['LOG_LEVEL'] || 'DEBUG'

  LOG.info 'Logger is ready'
end

post '/' do
  if authorised?
    LOG.info 'Got authorised request'
    ShareJob.perform_async(params)
  end
end

get '/' do
  if authorised?
    LOG.info 'Got authorised request'
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
