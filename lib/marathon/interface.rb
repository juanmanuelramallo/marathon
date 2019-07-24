# frozen_string_literal: true

module Marathon
  #
  # Interface object to render text and common strings into the stdout
  #
  class Interface
    #
    # Renders a header banner for the execution of a step
    #
    # @param step [Integer] Step to display in the banner
    #
    def render_step_execution_header(step)
      render_simple_banner("Executing step #{step}")
    end

    #
    # Renders a result header banner for the execution of a step
    #
    # @param step [Integer] Step to display in the banner
    #
    def render_step_result_header(step)
      puts string_with_padding("Step #{step}", 8).white.on_black
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
