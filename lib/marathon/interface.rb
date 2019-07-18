module Marathon
  class Interface
    attr_reader :commands_count, :messages

    def initialize(commands_count)
      @commands_count = commands_count
    end

    def empty_spaces(size)
      ' ' * size
    end

    def render_header
      str = "MARATHON: Running #{commands_count} commands"
      padding = 5
      puts "#{empty_spaces(str.size + padding * 2)}".on_black
      puts "#{string_with_padding(str, padding)}".white.on_black
      puts "#{empty_spaces(str.size + padding * 2)}".on_black
    end

    def render_divider
      puts (" " * 100 + "\n").light_blue.underline
    end

    def render_spacer
      puts "\n"
    end

    def string_with_padding(str, padding = 0)
      "#{empty_spaces(padding)}#{str}#{empty_spaces(padding)}"
    end
  end
end
