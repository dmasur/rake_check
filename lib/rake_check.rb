require "rake_check/version"
require 'rake_check/result'
require 'rake_check/executor'
require 'rake_check/checker/base'
require 'rake_check/checker/cucumber'
require 'rake_check/checker/rspec'
require 'rake_check/checker/rbp'
require 'rake_check/checker/yard'
require 'rake_check/checker/reek'
require 'rake_check/checker/cane'
require 'rake_check/checker/brakeman'
require 'rake_check/checker/coffee_lint'
require 'rake_check/checker/konacha'
require 'term/ansicolor'
##
# My empty Module
#
# @author dmasur
module RakeCheck
  # Your code goes here...
end

class String
  include Term::ANSIColor
end
