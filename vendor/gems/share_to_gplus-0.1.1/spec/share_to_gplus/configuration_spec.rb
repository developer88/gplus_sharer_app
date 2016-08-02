require 'spec_helper'
require 'share_to_gplus'

module ShareToGplus
  describe ShareToGplus::Configuration do
    subject { Configuration.new }

    describe '#login' do
      it 'default value is ""' do
        expect(subject.login).to eq(nil)
      end


    end

    describe '#login=' do
      it 'can set value' do
        subject.login = ''
        expect(subject.login).to eq('')
      end
    end

    context 'defaulte values' do
      it 'returns default value' do
        expect(subject.javascript_driver).to eq(:selenium)
      end
    end
  end
end
