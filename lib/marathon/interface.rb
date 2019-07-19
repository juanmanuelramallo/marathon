# frozen_string_literal: true

module Marathon
  #
  # Interface object to render text and common strings into the stdout
  #
  class Interface
    #
    # Renders a banner to stdout
    #
    # @param str [String] String to send to stdout
    # @param padding [Integer] Amount of empty spaces to use in the left and right side
    #
    def render_banner(str, padding = 3)
      empty = empty_spaces(str.size + padding * 2).on_black

      puts empty
      puts string_with_padding(str, padding).white.on_black
      puts empty
    end

    #
    # Renders a header banner for the execution of a run level
    #
    # @param run_level [Integer] Run level to display in the banner
    #
    def render_run_level_execution_header(run_level)
      render_simple_banner("Executing step #{run_level}")
    end

    #
    # Renders a result header banner for the execution of a run level
    #
    # @param run_level [Integer] Run level to display in the banner
    #
    def render_run_level_result_header(run_level)
      render_banner("Step #{run_level}")
    end

    #
    # Renders a new line character
    #
    def render_spacer
      puts "\n"
    end

    private

    def empty_spaces(size)
      ' ' * size
    end

    def render_simple_banner(str)
      puts string_with_padding(str).white.on_black
    end

    def string_with_padding(str, padding = 3)
      "#{empty_spaces(padding)}#{str}#{empty_spaces(padding)}"
    end
  end
end
