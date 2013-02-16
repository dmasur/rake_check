require_relative 'base'
module RakeCheck
  module Checker
    ##
    # BrakemanChecker checks the output for undocumented classes and methods
    #
    class Brakeman < Base
      def run
        run_command 'brakeman --exit-on-warn --no-progress --summary -q'
      end
    end
  end
end
