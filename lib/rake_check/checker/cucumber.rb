require 'colored'
require 'rake_check/checker/base'
##
# CucumberChecker checks the output for failed Scenarios
#
# @author dmasur
module RakeCheck
  module Checker
    class Cucumber < Base

      def run
        run_command({"COVERAGE" => "true"}, "cucumber features")
      end

    end
  end
end