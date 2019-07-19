# frozen_string_literal: true

require 'optparse'

Options = Struct.new(:commands)

# marathon -c 'bundle exec rubocop','yarn run js-lint','bundle exec rspec;;2'

module Marathon
  # Parser object to parse the options passed from bash
  # It will instantiate the command objects and make them available in the Options structure
  class Parser
    def parse(options)
      @args = Options.new
      opt_parser.parse!(options)
      @args
    end

    def interface
      @interface ||= Marathon::Interface.new(@commands_size)
    end

    private

    def commands_opts(opts)
      opts.on(
        "-c 'Command  A;;Level','Command B;;Level','...'", Array, 'List of commands to run'
      ) do |n|
        @commands_size = n.size

        @args.commands = n.map do |arg|
          command_text, level = arg.split(';;')
          Marathon::Command.new(command: command_text, run_level: level, interface: interface)
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
