require 'colorize'

module Marathon
  class Run
    attr_reader :commands, :interface

    def initialize(commands, interface)
      @commands = commands.group_by(&:run_level).sort.to_h
      @interface = interface
    end

    def run
      commands.each do |run_level, commands_list|
        interface.render_run_level_execution_header(run_level)

        commands_list.each &:execute
        commands_list.each &:join

        break unless commands_list.all? &:success?
      end

      interface.render_spacer

      commands.each do |run_level, commands_list|
        interface.render_run_level_result_header(run_level)
        commands_list.each &:render_result
     end
    end
  end
end
