class ShareJob
  include SuckerPunch::Job

  def perform(payload)
      logger = Log4heroku.log
      SuckerPunch.logger = logger

      share_this = ShareToGplus::It.new do |config|
        config.login = ENV['GPLUS_LOGIN']
        config.password = ENV['GPLUS_PASSWORD']
        config.text = payload['text']
        config.url =  payload['community']
        config.category = payload['category']
        config.link = payload['link']
        config.javascript_driver = :poltergeist
      end
      share_this.execute
  end
end
