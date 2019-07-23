# frozen_string_literal: true

RSpec.describe Marathon::Command do
  let(:command) do
    described_class.new(
      command: command_text, step: step, options: options
    )
  end
  let(:command_text) { 'echo hola' }
  let(:options) do
    {
      verbose: verbose
    }
  end
  let(:verbose) { true }
  let(:step) { nil }

  describe '#execute' do
    subject do
      command.execute
      command.join
      command.output
    end

    context 'a basic command' do
      it { is_expected.to eq "hola\n" }
    end

    context 'bad terminating command' do
      let(:command_text) { 'test 1 = 2' }

      it { is_expected.to eq '' }
    end

    context 'option verbose' do
      let(:expected_message) { "> Done '#{command_text}'\n" }

      it 'prints a message to stdout' do
        expect { subject }.to output(expected_message).to_stdout
      end

      context 'with verbose option as false' do
        let(:verbose) { false }

        it 'doest not print the message of command has completed' do
          expect { subject }.to_not output(expected_message).to_stdout
        end
      end
    end
  end

  # describe '#join' do
  #   subject { command.join }

  #   it 'sends join to the thread object' do
  #     allow(command.thread).to receive(:join).and_return(true)
  #     expect(subject).to eq true
  #   end
  # end

  describe '#success?' do
    before do
      command.execute
      command.join
    end

    subject { command.success? }

    context 'successfull command' do
      let(:command_text) { 'test 1 = 1' }

      it { is_expected.to eq true }
    end

    context 'failed command' do
      let(:command_text) { 'test 1 = 2' }

      it { is_expected.to eq false }
    end
  end

  describe '#render_result' do
    before do
      command.execute
      command.join
    end

    subject { command.render_result }

    it 'displays the status in stdout' do
      expect { subject }.to output(/Ok/).to_stdout
    end

    context 'option verbose' do
      let(:command_text) { 'test 1 = 1 && echo HOLA' }

      it 'prints successful command output' do
        expect { subject }.to output(/\nHOLA/).to_stdout
      end

      context 'verbose option as false' do
        let(:verbose) { false }

        it 'does not print output of the command' do
          expect { subject }.to_not output(/\nHOLA/).to_stdout
        end
      end
    end
  end
end
