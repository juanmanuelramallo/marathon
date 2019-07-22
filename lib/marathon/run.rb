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
    # @param commands [Array<Marathon::Command>] Array of commands to run
    # @param interface [Marathon::Interface] An instance of the interface object
    #
    def initialize(commands, interface)
      @commands = commands.group_by(&:step).sort.to_h
      @interface = interface
    end

    #
    # Runs all the commands by steps
    #
    # @return [nil] It renders the result to stdout upon termination of all commands
    #
    def run
      commands.each do |step, commands_list|
        interface.render_step_execution_header(step)

        commands_list.each(&:execute)
        commands_list.each(&:join)

        break unless commands_list.all?(&:success?)
      end

      render_result
    end

    private

    def render_result
      interface.render_spacer

      commands.each do |step, commands_list|
        interface.render_step_result_header(step)
        commands_list.each(&:render_result)
      end
    end
  end
end
