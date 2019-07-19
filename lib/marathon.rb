# frozen_string_literal: true

#
# Running several commands with a pretty output result and different levels
# to allow execution if previous levels have been successful
#
# See {#Marathon::Run}
#
module Marathon
  require 'marathon/command'
  require 'marathon/interface'
  require 'marathon/parser'
  require 'marathon/run'
  require 'marathon/version'
end
