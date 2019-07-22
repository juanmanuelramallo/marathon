# frozen_string_literal: true

require 'optparse'

module Marathon
  #
  # Parser object to parse the options passed from bash
  #
  # It will instantiate the command objects and make them available in the Options structure
  #
  # Examples:
  # - `marathon -c 'bundle exec rubocop','yarn run js-lint','bundle exec rspec;;2'`
  #   - It will parse the first two commands to be in the first step and rspec in the second step
  # - `marathon -c 'brakeman;;1','npx cypress run;;2'`
  #   - It will parse brakeman to be in the first step and cypress in the second step
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
      @args = Options.new
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
        "-c 'Command  A;;Level','Command B;;Level','...'", Array, 'List of commands to run'
      ) do |n|
        args.commands = n.map do |arg|
          command_text, step = arg.split(';;')
          Marathon::Command.new(command: command_text, step: step)
        end
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
