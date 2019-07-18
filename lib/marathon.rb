module Marathon
  class Error < StandardError; end

  require 'marathon/command'
  require 'marathon/interface'
  require 'marathon/parser'
  require 'marathon/run'
  require 'marathon/version'
end
