# frozen_string_literal: true

RSpec.describe Marathon::Run do
  let(:interface) { Marathon::Interface.new(1) }
  let(:commands) { [Marathon::Command.new('echo hola', interface)] }
  let(:run) { Marathon::Run.new(commands, interface) }

  describe '#run' do
    subject { run.run }

    it 'runs all commands' do
      expect
    end
  end
end
