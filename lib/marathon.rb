module Marathon
  class Error < StandardError; end

  require 'marathon/version'
  require 'marathon/parser'
  require 'marathon/run'
end
