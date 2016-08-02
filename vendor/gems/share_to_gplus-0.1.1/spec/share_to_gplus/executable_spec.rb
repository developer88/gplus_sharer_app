require 'spec_helper'
require 'share_to_gplus'

module ShareToGplus
  describe ShareToGplus::Executable do
    subject { ShareToGplus::Executable }

    describe 'self.#invoke' do
      before do
        expect_any_instance_of(subject).to receive(:parse_arguments).and_return(true)
        expect_any_instance_of(subject).to receive(:invoke).and_return(false)
      end

      it { subject.invoke({}) }
    end

    describe '#parse_arguments' do
      context 'when no arguments provided' do
        let(:arguments) { [] }

        it { expect{ subject.invoke(arguments) }.to raise_exception(RuntimeError) }
      end

      context 'when invalid arguments provided' do
        let(:arguments) { %w(--login test --password) }

        it { expect{ subject.invoke(arguments) }.to raise_exception(OptionParser::MissingArgument) }
      end

      context 'when correct arguments provided' do
        let(:arguments) { %w(--login test --password pass --url http://test.com) }
        before do
          expect_any_instance_of(subject).to receive(:invoke).and_return(true)
        end

        it { expect(subject.invoke(arguments)).to be true }
      end
    end

    describe '#invoke' do
      subject { ShareToGplus::Executable.new }
      let(:it_class) { ShareToGplus::It }

      before do
        expect(it_class).to receive(:new).and_call_original
        expect_any_instance_of(it_class).to receive(:execute).and_return(true)
      end

      it { subject.invoke }
    end
  end
end
