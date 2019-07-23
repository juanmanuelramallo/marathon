# frozen_string_literal: true

require 'English'

module Marathon
  #
  # A command object which receives the command text, a step (number)
  #
  # It can execute commands and store its output to be able to render the result later.
  #
  # If no step is specified, FIRST_STEP will be used
  #
  class Command
    # Output of command
    attr_accessor :output
    # Thread object
    attr_accessor :thread

    # Command text to run in bash
    attr_reader :command
    # Hash of options
    attr_reader :options
    # Level or step where this command will be run
    attr_reader :step

    # First step value to use in the step attribute
    FIRST_STEP = 1

    #
    # A new instance of command
    #
    # @param command [String] Command text to run in bash
    # @param step [Integer] Level or step where this command will be run
    # @param options [Hash] Options available are:
    #   - "silent" (boolean) used to determine wether to print information about
    #     the execution to stdout or not
    #
    def initialize(command:, step: FIRST_STEP, options: {})
      @command = command
      @options = options
      @step = step ? step.to_i : FIRST_STEP
      @success = nil
    end

    #
    # Executes the command an stores the success value.
    # It prints to stdout when command finished unless silent option is present
    #
    # @return [Thread] Thread of command execution
    #
    def execute
      @thread = Thread.new do
        @output = `#{command} 2>&1`
        @success = $CHILD_STATUS.success?
        puts "> Done '#{command}'" unless options[:silent]
      end
    end

    #
    # Passes join message to thread
    #
    # @return [Thread] Thread of command execution
    #
    def join
      thread.join
    end

    #
    # Present a well formatted output result to stdout
    #
    # @return [nil]
    #
    def render_result
      puts <<~STR
        #{command.white.on_black}
        #{status_text}
        #{output}
      STR
    end

    #
    # Return the success instance variable value
    #
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
