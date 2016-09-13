class Log4heroku
  def self.log
    @logger ||= Logging.logger[self]
    @logger.add_appenders(
      Logging.appenders.file(::File.new(::File.join(::File.dirname(::File.expand_path(__FILE__)), '..', 'log', 'debug.log'), 'a+'))
    )
    @logger.level = :debug
    @logger
  end
end