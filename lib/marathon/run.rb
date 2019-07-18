require 'colorize'

module Marathon
  class Run
    attr_reader :commands, :interface

    def initialize(commands, interface)
      @commands = commands
      @interface = interface
    end

    def run
      interface.render_header
      commands.each &:execute
      commands.each &:join
      interface.render_spacer
      commands.each &:render_result
    end
  end
end
