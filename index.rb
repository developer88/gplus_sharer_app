# myapp.rb
require 'sinatra'
require 'share_to_gplus'

post '/' do
  begin
    status 403 unless post_to_gplus
  rescue Exception => e
    puts "Something went wrong: #{e.inspect}"
  end
end

get '/debug/screenshot' do
  list = Dir.glob("./*.*").map{|f| f.split('/').last}
  list2 = Dir.glob("../*.*").map{|f| f.split('/').last}
  list3 = Dir.glob("/app/./*.*").map{|f| f.split('/').last}
  #raise list.inspect + list2.inspect + list3.inspect
  file = Dir.glob("/app/./*.*").map{|f| f.split('/').last}.select{|filename| filename.include?('png') }.last
  send_file "/app/./#{file}", :filename => file, :type => 'Application/octet-stream'
end

# params
#   secret
#   link to share
#   text to share
#   category to pick
#   community url
def post_to_gplus
  return false if !ENV['SECRET_CODE'] || ENV['SECRET_CODE'] != params['secret']
  share_this = ShareToGplus::It.new do |config|
    config.login = ENV['GPLUS_LOGIN']
    config.password = ENV['GPLUS_PASSWORD']
    config.text = params['text']
    config.url =  params['community']
    config.category = params['category']
    config.link = params['link']
    config.javascript_driver = :poltergeist
  end
  share_this.execute
end
