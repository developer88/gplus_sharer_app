require 'optparse'

module ShareToGplus
  class Executable
    attr_accessor :options

    def self.invoke(args)
      executable = new
      executable.invoke if executable.parse_arguments(args)
    end

    def initialize
      @options = {}
    end

    def parse_arguments(args)
      OptionParser.new do |opts|
        opts.banner = 'Usage: sharetogplus [options]'

        on_service_arguments(opts)
        on_mandatory_arguments(opts)
        on_content_arguments(opts)
      end.parse!(args)

      raise 'No arguments specified!' if @options.empty?

      true
    end

    def invoke
      share_this = ShareToGplus::It.new do |config|
        config.login = @options[:login]
        config.password = @options[:password]
        config.text = @options[:text]
        config.url = @options[:url]
        config.category = @options[:category]
        config.link = @options[:link]
        config.javascript_driver = @options[:javascript_driver] if @options[:javascript_driver]
      end
      share_this.execute
    end

    private

    def on_content_arguments(opts)
      opts.on('--link LINK', 'LINK to share in Google+ Community') do |v|
        @options[:link] = v
      end

      opts.on('-t', '--text TEXT', 'TEXT to share in Google+ Community') do |v|
        @options[:text] = v
      end

      opts.on('-c', '--category CATEGORY', 'CATEGORY for new post in Google+ Community') do |v|
        @options[:category] = v
      end
    end

    def on_mandatory_arguments(opts)
        opts.on('-l', '--login LOGIN', 'LOGIN for authorising in Google+') do |v|
          @options[:login] = v
        end

        opts.on('-p', '--password PASSWORD', 'PASSWORD for authorising in Google+') do |v|
          @options[:password] = v
        end

        opts.on('-u', '--url URL', 'URL of Google+ community to share a post to') do |v|
          @options[:url] = v
        end
    end

    def on_service_arguments(opts)
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end

      opts.on_tail('-v', '--version', 'Show version') do
        puts VERSION
        exit
      end

      opts.on('-d', '--javascript_driver DRIVER', 'Javascript Driver. "selenium" by default') do |v|
        @options[:javascript_driver] = v
      end
    end
  end
end

