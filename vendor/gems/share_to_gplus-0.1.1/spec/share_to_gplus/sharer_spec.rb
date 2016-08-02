require 'spec_helper'
require 'share_to_gplus'

module ShareToGplus
  describe ShareToGplus::Sharer do
    subject { ShareToGplus::Sharer }

    describe '#initialize' do
      before do
        expect(Capybara).to receive(:configure).and_call_original
      end

      it { subject.new }
    end

    # No additional Capybara tests here.
    # Since i use Capybara to browse Google's pages it is quite hard to
    #   prepare dummy Google-like page for tests and always keep it up to date.
  end
end
