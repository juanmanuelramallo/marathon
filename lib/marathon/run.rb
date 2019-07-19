# frozen_string_literal: true

require 'colorize'

module Marathon
  #
  # Entry object to call in order to run a set of commands
  #
  class Run
    # Array of commands objects
    attr_reader :commands
    # An instance of the interface object
    attr_reader :interface

    #
    # A new instance of run
    #
    # @param commands [Marathon::Command[]] Array of commands to run
    # @param interface [Marathon::Interface] An instance of the interface object
    #
    def initialize(commands, interface)
      @commands = commands.group_by(&:run_level).sort.to_h
      @interface = interface
    end

    #
    # Runs all the commands by run level
    #
    # @return [nil] It renders the result to stdout upon termination of all commands
    #
    def run
      commands.each do |run_level, commands_list|
        interface.render_run_level_execution_header(run_level)

        commands_list.each(&:execute)
        commands_list.each(&:join)

        break unless commands_list.all?(&:success?)
      end

      render_result
    end

    private

    def render_result
      interface.render_spacer

      commands.each do |run_level, commands_list|
        interface.render_run_level_result_header(run_level)
        commands_list.each(&:render_result)
      end
    end
  end
end
