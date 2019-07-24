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

      context 'with several steps' do
        let(:options) { ['-c', 'test 1 = 1,echo HOLA', '-c', 'test 2 = 2'] }

        it 'returns three commands' do
          expect(subject.commands.size).to eq 3
        end

        it 'returns two steps' do
          expect(subject.commands.map(&:step).uniq.sort).to eq [1, 2]
        end
      end

      context 'with verbose option' do
        let(:options) { ['-c', 'test 1 = 1', '-v'] }

        it 'returns true for the verbose option' do
          expect(subject.verbose).to eq true
        end
      end
    end

    context 'with invalid arguments' do
      let(:options) { ['whatever'] }

      it 'exits the execution' do
        expect { subject }.to raise_error SystemExit
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
