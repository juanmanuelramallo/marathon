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

    # Command text to run in bash
    attr_reader :command
    # Hash of options
    attr_reader :options
    # Level or step where this command will be run
    attr_reader :step

    # First step value to use in the step attribute
    FIRST_STEP = 1

    # Hash of default options
    DEFAULT_OPTIONS = {
      verbose: false
    }.freeze

    #
    # A new instance of command
    #
    # @param command [String] Command text to run in bash
    # @param step [Integer] Level or step where this command will be run
    # @param options [Hash] Options available are:
    #   - "verbose" (boolean) used to determine wether to print information after execution
    #
    def initialize(command:, step: FIRST_STEP, options: DEFAULT_OPTIONS)
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
      @output = `#{command} 2>&1`
      @success = $CHILD_STATUS.success?
      puts "> Done '#{command}'" if options[:verbose]
      execution_result
    end

    #
    # Return the success instance variable value
    #
    def success?
      @success
    end

    private

    def execution_result
      {
        result_string: result_string,
        success: success?
      }
    end

    def result_string
      <<~STR
        #{status_text}#{" #{command}".white.on_black}
        #{output if show_output?}
      STR
    end

    def show_output?
      !success? || options[:verbose]
    end

    def status_text
      if success?.nil?
        ' Not run '.black.on_light_white
      elsif success?
        '   Ok   '.black.on_green
      else
        ' Failed '.white.on_red
      end
    end
  end
end
