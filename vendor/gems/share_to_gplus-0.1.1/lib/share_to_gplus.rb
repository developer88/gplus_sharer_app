require 'share_to_gplus/version'

module ShareToGplus

  require 'share_to_gplus/configuration'
  require 'share_to_gplus/it'
  require 'share_to_gplus/sharer'
  require 'share_to_gplus/executable'

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
