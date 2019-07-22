# frozen_string_literal: true

RSpec.describe Marathon::Parser do
  describe '#parse' do
    subject { described_class.new.parse(options) }

    context 'with valid arguments' do
      let(:options) { ['-c', 'test 1 = 1'] }

      it 'returns an options object' do
        expect(subject).to be_kind_of Marathon::Parser::Options
      end

      it 'returns a command to run' do
        expect(subject.commands.first).to be_kind_of Marathon::Command
      end
    end

    context 'with invalid arguments' do
      let(:options) { ['whatever'] }

      it 'returns an empty options object' do
        expect(subject.commands).to be_nil
      end
    end

    context 'asking for help' do
      let(:options) { ['-h'] }

      it 'exits the execution' do
        expect { subject }.to raise_error SystemExit
      end
    end
  end
end
