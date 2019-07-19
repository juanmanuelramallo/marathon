# frozen_string_literal: true

require 'English'

module Marathon
  #
  # A command object which receives the command text, a run level number, an interface object and
  # an options hash.
  #
  # It can execute commands and store its output to be able to render the result later.
  #
  # If no run level is specified, FIRST_STEP will be used
  #
  class Command
    # Output of command
    attr_accessor :output
    # Thread object
    attr_accessor :thread

    # Command text to run in bash
    attr_reader :command
    # An instance of the interface object
    attr_reader :interface
    # Hash of options
    attr_reader :options
    # Level or step where this command will be run
    attr_reader :run_level

    # First step value to use in the run level attribute
    FIRST_STEP = 1

    #
    # A new instance of command
    #
    # @param command [String] Command text to run in bash
    # @param run_level [Integer] Level or step where this command will be run
    # @param interface [Marathon::Interface] An instance of the interface object
    # @param options [Hash] Options available are:
    #   - "silent" (boolean) used to determine wether to print information about
    #     the execution to stdout or not
    #
    def initialize(command:, run_level: FIRST_STEP, interface:, options: {})
      @command = command
      @interface = interface
      @options = options
      @run_level = run_level ? run_level.to_i : FIRST_STEP
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
        @output = `#{command}`
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
        $ #{command.white.on_black}
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
