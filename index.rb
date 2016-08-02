# myapp.rb
require 'sinatra'
require 'share_to_gplus'

post '/' do
  status 403 unless post_to_gplus
end

# debugging
get '/' do
  status 403 unless post_to_gplus
end

# params
#   secret
#   link to share
#   text to share
#   category to pick
#   community url
def post_to_gplus
  return false if ENV['SECRET_CODE'].empty? || ENV['SECRET_CODE'] !== params['secret']
  share_this = ShareToGplus::It.new do |config|
    config.login = ENV['GPLUS_LOGIN']
    config.password = ENV['GPLUS_PASSWORD']
    config.text = params['text']
    config.url =  params['community']
    config.category = params['category']
    config.link = params['link']
  end
end
