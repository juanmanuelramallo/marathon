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
    # Basic structure to store parsed commands and options
    Options = Struct.new(:commands, :processes, :verbose)

    # Parsed arguments object
    attr_accessor :args

    #
    # A new instance of the Parser
    #
    def initialize
      @args = Options.new([], 0, false)
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

      if args.commands.empty?
        puts opt_parser
        exit
      end

      parse_commands

      args
    end

    private

    def commands_opts(opts)
      opts.on(
        "-c 'Command A','Command B' -c 'Command C'", Array, 'List of commands to run (required)'
      ) do |n|
        commands = n.map do |command_text|
          { command: command_text, step: @current_step }
        end

        @current_step += 1
        args.commands.concat(commands)
      end
    end

    def help_opts(opts)
      opts.on('-h', '--help', 'Prints this help and the version information') do
        puts "Marathon version: #{Marathon::VERSION}"
        puts opts
        exit
      end
    end

    def parallel_opts(opts)
      opts.on('-p', '--parallel PROCESSES',
              'Executes the commands in parallel. Pass the amount of processes to use.') do |n|
        args.processes = n.to_i
      end
    end

    def parse_commands
      args.commands = args.commands.map do |command|
        Marathon::Command.new(
          command: command[:command], step: command[:step], options: { verbose: args.verbose }
        )
      end
    end

    def opt_parser
      @opt_parser ||= OptionParser.new do |opts|
        opts.banner = 'Usage: marathon [options]'

        commands_opts(opts)
        parallel_opts(opts)
        help_opts(opts)
        verbose_opts(opts)
      end
    end

    def verbose_opts(opts)
      opts.on('-v', '--verbose', 'Prints more information on execution') do |_n|
        args.verbose = true
      end
    end
  end
end
