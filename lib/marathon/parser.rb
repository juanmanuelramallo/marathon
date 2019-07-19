require 'optparse'

Options = Struct.new(:commands)

# marathon -c 'bundle exec rubocop','yarn run js-lint','bundle exec rspec;;2'

module Marathon
  class Parser
    def parse(options)
      args = Options.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: marathon [options]"

        opts.on(
          "-c 'Command  A;;Level','Command B;;Level','...'",
          Array,
          "List of commands to run"
        ) do |n|
          @commands_size = n.size

          args.commands = n.map do |arg|
            command_text, level = arg.split(';;')
            Marathon::Command.new(command: command_text, run_level: level, interface: interface)
          end
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end

      opt_parser.parse!(options)
      args
    end

    def interface
      @interface ||= Marathon::Interface.new(@commands_size)
    end
  end
end
