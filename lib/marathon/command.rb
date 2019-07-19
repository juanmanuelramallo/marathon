module Marathon
  class Command
    attr_accessor :output, :thread
    attr_reader :command, :interface, :options, :run_level

    FIRST_STEP = 1

    def initialize(command:, run_level:, interface:, options: {})
      @command = command
      @interface = interface
      @options = options
      @run_level = run_level ? run_level.to_i : FIRST_STEP
      @success = nil
    end

    def execute
      @thread ||= Thread.new do
        @output = `#{command}`
        @success = $?.success?
        puts "> Done '#{command}'" unless options[:silent]
      end
    end

    def join
      thread.join
    end

    def render_result
      puts <<-STR
$ #{command.white.on_black}
#{status_text}
#{output}
      STR
    end

    def success?
      @success
    end

    private

    def status_text
      if success?.nil?
        '   Not run  '.black.on_light_white
      elsif success?
        '     Ok     '.black.on_green
      else
        '   Failed   '.white.on_red
      end
    end
  end
end
