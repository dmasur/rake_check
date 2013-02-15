##
# BrakemanChecker checks the output for undocumented classes and methods
#
# @author dmasur
module RakeCheck
  module Checker
    class Brakeman < Base

      def run
        run_command 'brakeman --exit-on-warn --no-progress --summary -q'
      end

    end
  end
end
