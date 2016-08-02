require 'spec_helper'
require 'share_to_gplus'

module ShareToGplus
  describe ShareToGplus::It do
    subject { ShareToGplus::It.new }

    describe '#execute' do
      let(:it_class) { ShareToGplus::It }
      let(:sharer_class) { ShareToGplus::Sharer }

      before do
        expect_any_instance_of(it_class).to receive(:navigate).and_return(true)
        expect_any_instance_of(it_class).to receive(:share).and_return(true)
        expect_any_instance_of(sharer_class).to receive(:wait_a_little_bit).and_return(true)
      end

      it 'should return true' do
        expect(subject.execute).to be true
      end
    end

    describe '#initialize' do
      before do
        expect(Sharer).to receive(:new).and_call_original
        expect(ShareToGplus).to receive(:configuration).and_call_original
      end

      it { subject }
    end
  end
end
