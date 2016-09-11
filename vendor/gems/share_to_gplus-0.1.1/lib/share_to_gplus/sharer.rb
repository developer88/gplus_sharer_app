module ShareToGplus
  require 'capybara/dsl'
  require 'capybara/poltergeist'
  require 'capybara-screenshot'

  class Sharer

    include Capybara::DSL

    def initialize(url: "", config: ShareToGplus.configuration)
      @url = url
      Capybara.configure do |capybara_config|
        capybara_config.run_server = false
        capybara_config.default_driver = config.javascript_driver.to_sym
        capybara_config.app_host = url
        capybara_config.default_max_wait_time = 10
        capybara_config.raise_server_errors = false
      end
      @google_plus_version = "old" # by default

      # Set headers to pass Google authorization
      Capybara.current_session.driver.headers = {
        'Upgrade-Insecure-Requests' => 1,
        'User-Agent' =>  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.89 Safari/537.36'
      }
      Capybara::Screenshot.autosave_on_failure = false
    end

    def visit_community
      visit @url
      page.current_window.resize_to(1280, 1024)
    end

    def login(login:, password:)
      return unless page.has_selector?("#gb_70")

      find("#gb_70").click
      fill_in 'email', :with => login
      find("input#next").click
      fill_in 'Passwd', :with => password
      find("input#signIn").click
    end

    def try_new_google_plus
      @google_plus_version = "new" if !page.has_selector?("div.Ege.qMc")
      if @google_plus_version == "old" && page.has_selector?(".d-k-l.b-c.b-c-Wa")
        find(".d-k-l.b-c.b-c-Wa", visible: :all).click
        wait_a_little_bit
        @google_plus_version = "new"
      end
    end

    def open_share_dialog
      puts "Current url is #{current_url}"
      find("div.jXDCJf.Tek5Ce.BDrJf").click if @google_plus_version == "new"
      find("div.kqa.es").click if @google_plus_version == "old"
    end

    def fill_text(text:)
      if @google_plus_version == "new"
        dialog = find("[role='dialog']")
        dialog.find("div:nth-child(1) div:nth-child(2) textarea").set(text)
      else
        find("div.df.b-K.b-K-Xb.URaP8").send_keys(text)
      end
    end

    def fill_link(link:)
      raise  "Gplus version is #{@google_plus_version.inspect}" + " Current url is #{current_url}" + " Old link button exist #{page.has_selector?('span.d-s.ph.pZ').inspect} #{Capybara::Screenshot.screenshot_and_save_page.inspect}"
      if @google_plus_version == "new"
        find(:xpath, '//div[@aria-label="Add link"]').click
        dialog = find(:xpath, '//div[@role="dialog"]')
        dialog.find('input').set(link)
        dialog.find('input').send_keys :enter
      else
        find("span.d-s.ph.pZ").click
        wait_a_little_bit
        find("div.MR input.fm").set(link)
      end
    end

    def close_dialog
      find(:xpath, '//span[contains(., "Post")]').click if @google_plus_version == "new"
    end

    def set_category(name:)
      find(:xpath, "//div[@data-name='#{name}']").click if @google_plus_version == "new"
      if @google_plus_version == "old"
        find("div.BA.pi.d-e.d-k-l.d-r-c").click
        find(:xpath, "//div[@class='An zr d-r']/div[@class='Vm d-A']//span[. = 'Test']/../..").click
        find("div.d-k-l.b-c.b-c-Ba.qy.jt").click
      end
    end

    # TODO: Some of these helpers already moved to wts gem
    #         https://source.xing.com/qa/wts/blob/develop/lib/wts/spec/scroll.rb
    #       So we need to start using this
    # Scroll page by n pixels
    # Positive y - scroll down
    # Negative y - scroll up
    def scroll_page_by(x: 0, y: 0)
      object = @browser || page
      object.execute_script("return window.scrollBy(#{x},#{y})")
    end

    # Scroll page to certain element
    def scroll_into_viewport(element:, offset: 0)
      scroll_page_by(x: 0, y: "#{element}.getBoundingClientRect().top + #{offset}")
    end

    def scroll_to_add_post_button
      scroll_into_viewport(element: "document.querySelectorAll('.jXDCJf.Tek5Ce.BDrJf')[0]")
    end

    def wait_a_little_bit
      sleep(5)
    end

  end
end