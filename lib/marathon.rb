# frozen_string_literal: true

# Main object to run a marathon of commands
module Marathon
  class Error < StandardError; end

  require 'marathon/command'
  require 'marathon/interface'
  require 'marathon/parser'
  require 'marathon/run'
  require 'marathon/version'
end
