module ShareToGplus
  class Configuration
    attr_accessor :login, :password, :text, :link, :category, :url,
                  :javascript_driver

    def initialize
      %w(login password text link category url javascript_driver).each do |var|
        instance_variable_set("@#{var}", nil)
      end
      @javascript_driver ||= :selenium # set default driver
    end
  end
end
