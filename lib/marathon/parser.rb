require 'optparse'

Options = Struct.new(:commands)

module Marathon
  class Parser
    def self.parse(options)
      args = Options.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: marathon [options]"

        opts.on(
          "-c 'Command  A','Command B','...'",
          Array,
          "List of commands to run"
        ) do |n|
          args.commands = n
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end

      opt_parser.parse!(options)
      return args
    end
  end
end
