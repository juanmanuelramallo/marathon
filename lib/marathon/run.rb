# frozen_string_literal: true

require 'colorize'
require 'parallel'

module Marathon
  #
  # Entry object to call in order to run a set of commands
  #
  class Run
    # Hash of results of commands
    attr_accessor :results

    # Array of commands objects
    attr_reader :commands
    # An instance of the interface object
    attr_reader :interface
    # Amount of processes to use in parallel execution
    attr_reader :processes

    #
    # A new instance of run
    #
    # @param commands [Array<Marathon::Command>] Array of commands to run
    # @param interface [Marathon::Interface] An instance of the interface object
    # @param processes [Integer] Amount of processes to use in parallel execution
    #
    def initialize(commands:, interface:, processes:)
      @commands = commands.group_by(&:step).sort.to_h
      @interface = interface
      @processes = processes
      @results = {}
    end

    #
    # Runs all the commands by steps
    #
    # @return [nil] It renders the result to stdout upon termination of all commands
    #
    def run
      commands.each do |step, commands_list|
        interface.render_step_execution_header(step)

        step_results = Parallel.map(commands_list, in_processes: processes, &:execute)

        results[step] = step_results

        break unless step_results.all? { |result| result[:success] }
      end

      render_result
    end

    private

    def render_result
      interface.render_spacer

      results.each do |step, results|
        interface.render_step_result_header(step)
        results.each do |result|
          puts result[:result_string]
        end
      end
    end
  end
end
