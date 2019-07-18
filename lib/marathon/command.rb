module Marathon
  class Command
    attr_accessor :output, :thread
    attr_reader :command, :interface, :index, :options

    def initialize(command, interface, index, options = {})
      @command = command
      @interface = interface
      @index = index
      @options = options
    end

    def execute
      @thread ||= Thread.new do
        @output = `#{command}`
        puts "✓ '#{command}' DONE" unless options[:silent]
      end
    end

    def join
      thread.join
    end

    def render_result
      puts <<-STR
#{command.white.on_black}
#{output}
      STR
    end
  end
end
