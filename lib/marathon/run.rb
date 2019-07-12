require 'colorize'

module Marathon
  class Run
    attr_accessor :threads
    attr_reader :commands

    def initialize(commands)
      @commands = commands
      @threads = []
      @outputs = {}
    end

    def run
      puts "Running...\n\n"

      commands.each do |command|
        @threads << Thread.new do
          @outputs[command] = `#{command}`
          puts "'#{command}' done"
        end
      end

      @threads.each &:join

      render_divider

      @outputs.each do |command, output|
        str_block = ' ' * (command.size + 4)
        puts str_block.on_black
        puts "  #{command}  ".white.on_black
        puts str_block.on_black
        puts ""
        puts output
        render_divider
      end
    end

    private

    def render_divider
      puts (" " * 64 + "\n").light_blue.underline
    end
  end
end
