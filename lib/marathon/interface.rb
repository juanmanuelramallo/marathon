# frozen_string_literal: true

module Marathon
  # Interface object to render text and common strings into the standard output
  class Interface
    attr_reader :commands_size, :messages

    def initialize(commands_size)
      @commands_size = commands_size
    end

    def empty_spaces(size)
      ' ' * size
    end

    def render_banner(str, padding = 3)
      empty = empty_spaces(str.size + padding * 2).on_black

      puts empty
      puts string_with_padding(str, padding).white.on_black
      puts empty
    end

    def render_divider
      puts ' ' * 100 + "\n".light_blue.underline
    end

    def render_run_level_execution_header(run_level)
      render_simple_banner("Executing step #{run_level}")
    end

    def render_run_level_result_header(run_level)
      render_banner("Step #{run_level}")
    end

    def render_simple_banner(str)
      puts string_with_padding(str).white.on_black
    end

    def render_spacer
      puts "\n"
    end

    def string_with_padding(str, padding = 3)
      "#{empty_spaces(padding)}#{str}#{empty_spaces(padding)}"
    end
  end
end
