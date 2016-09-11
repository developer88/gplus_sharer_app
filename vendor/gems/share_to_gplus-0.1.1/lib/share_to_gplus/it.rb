module ShareToGplus
  class It
    attr_accessor :config

    def initialize
      @config = ShareToGplus.configuration
      yield(@config) if block_given?
      @sharer = Sharer.new(url: config.url, config: @config)
    end

    def execute
      navigate
      share
      @sharer.wait_a_little_bit
      true
    end

    private

    def navigate
      @sharer.visit_community
      @sharer.login(login: config.login, password: config.password)
      @sharer.try_new_google_plus
    end

    def share
      @sharer.scroll_to_add_post_button
      @sharer.open_share_dialog
      #@sharer.fill_link(link: config.link) if config.link
      #@sharer.fill_text(text: config.text)
      #@sharer.close_dialog
      #@sharer.set_category(name: config.category)
    end
  end
end
