RSpec.describe Marathon::Command do
  let(:command) { described_class.new(command_text, interface, options) }
  let(:command_text) { 'echo hola' }
  let(:interface) { Marathon::Interface.new(1) }
  let(:options) do
    {
      silent: true
    }
  end

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
        expect { subject }.to_not output("✓ 'echo hola' DONE\n").to_stdout
      end

      context 'without silent option' do
        let(:options) do
          {}
        end

        it 'prints the message of command has completed' do
          expect { subject }.to output("✓ 'echo hola' DONE\n").to_stdout
        end
      end
    end
  end

  describe '#join' do
    subject { command.join }

    it 'sends join to the thread object' do
      allow(command.thread).to receive(:join).and_return(true)
      expect(subject).to eq true
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
