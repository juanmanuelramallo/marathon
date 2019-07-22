# frozen_string_literal: true

#
# Running several commands with a pretty output results and several steps
# to allow execution of commands grouped by steps and halt execution
# if the previous step have been unsuccessful
#
# @see Marathon::Run
#
module Marathon
  require 'marathon/command'
  require 'marathon/interface'
  require 'marathon/parser'
  require 'marathon/run'
  require 'marathon/version'
end
