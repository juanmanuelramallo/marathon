# frozen_string_literal: true

RSpec.describe Marathon::Command do
  let(:command) do
    described_class.new(
      command: command_text, run_level: run_level, interface: interface, options: options
    )
  end
  let(:command_text) { 'echo hola' }
  let(:interface) { Marathon::Interface.new }
  let(:options) do
    {
      silent: true
    }
  end
  let(:run_level) { nil }

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

    context 'standard output' do
      it 'does not print any message to stdout' do
        expect { subject }.to_not output("> Done 'echo hola'\n").to_stdout
      end

      context 'without silent option' do
        let(:options) do
          {}
        end

        it 'prints the message of command has completed' do
          expect { subject }.to output("> Done 'echo hola'\n").to_stdout
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

  # describe '#render_result' do
  #   before { command.execute }

  #   subject { command.render_result }

  #   it 'displays the output in stdout' do
  #     expect { subject }.to output("#{'echo hola'.white.on_black}\nhola\n").to_stdout
  #   end
  # end
end
