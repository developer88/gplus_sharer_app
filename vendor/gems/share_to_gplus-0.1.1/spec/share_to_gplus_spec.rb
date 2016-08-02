require 'spec_helper'
require 'share_to_gplus'

describe ShareToGplus do
  describe '#configure' do
    let(:url) { 'http://someurl.com' }

    before :each do
      ShareToGplus.configure do |config|
        config.url = url
      end
    end

    it 'returns an array with 10 elements' do
      sharer = ShareToGplus::It.new

      expect(sharer.config.url).to eq(url)
    end

    after :each do
      ShareToGplus.reset
    end
  end

  describe '#reset' do
    before :each do
      ShareToGplus.configure do |config|
        config.login = ''
      end
    end

    it 'resets the configuration' do
      ShareToGplus.reset

      config = ShareToGplus.configuration

      expect(config.login).to eq(nil)
    end
  end
end
