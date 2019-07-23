# frozen_string_literal: true

require 'optparse'

module Marathon
  #
  # Parser object to parse the options passed from bash
  #
  # It will instantiate the command objects and make them available in the Options structure
  #
  # @example
  #   $ marathon -c 'bundle exec rubocop','yarn run js-lint' -c 'bundle exec rspec'
  #   # It will parse the first two commands to be in the first step and rspec in the second step
  # @example
  #   $ marathon -c 'brakeman' -c 'npx cypress run' -c 'eslint .'
  #   # It will parse brakeman to be in the first step, cypress in the second step and eslint
  #     at the third step
  #
  class Parser
    # Basic structure to store parsed commands
    Options = Struct.new(:commands)

    # Parsed arguments object
    attr_accessor :args

    #
    # A new instance of the Parser
    #
    def initialize
      @args = Options.new([])
      @current_step = Marathon::Command::FIRST_STEP
    end

    #
    # Parses the options from the bash command
    #
    # @param options [Array] ARGV array to parse
    # @return [Options] An instance of the options structure
    #
    def parse(options)
      opt_parser.parse!(options)
      args
    end

    private

    def commands_opts(opts)
      opts.on(
        "-c 'Command A','Command B' -c 'Command C'", Array, 'List of commands to run'
      ) do |n|
        commands = n.map do |command_text|
          Marathon::Command.new(command: command_text, step: @current_step)
        end

        @current_step += 1
        args.commands.concat(commands)
      end
    end

    def opt_parser
      @opt_parser ||= OptionParser.new do |opts|
        opts.banner = 'Usage: marathon [options]'

        commands_opts(opts)

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end
    end
  end
end
