# frozen_string_literal: true

RSpec.describe Marathon::Run do
  let(:interface) { Marathon::Interface.new }
  let(:commands) { [Marathon::Command.new(command: 'echo hola', interface: interface)] }
  let(:run) { Marathon::Run.new(commands, interface) }

  describe '#run' do
    subject { run.run }

    it 'runs all commands' do
      expect { subject }.to change { commands.first.success? }.to true
    end

    context 'with a failed step' do
      let(:commands) do
        [
          Marathon::Command.new(command: 'test 1 = 1', interface: interface),
          Marathon::Command.new(command: 'test 1 = 2', interface: interface, step: 2),
          Marathon::Command.new(command: 'test 2 = 2', interface: interface, step: 3)
        ]
      end

      it 'runs the first command' do
        expect { subject }.to change { commands[0].success? }.to true
      end

      it 'runs the second command and fails' do
        expect { subject }.to change { commands[1].success? }.to false
      end

      it 'does not run the third command' do
        expect { subject }.to_not change { commands[2].success? }
      end
    end
  end
end
