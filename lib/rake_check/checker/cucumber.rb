require 'colored'
require 'rake_check/checker/base'
module RakeCheck
  module Checker
    ##
    # CucumberChecker checks the output for failed Scenarios
    class Cucumber < Base
      def run
        run_command({"COVERAGE" => "true"}, "cucumber features")
      end
    end
  end
end