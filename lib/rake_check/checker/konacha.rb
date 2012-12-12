require 'colored'
##
# Konacha Checker checks for konacha Errors in you Javascripttests
#
# @author dmasur
module RakeCheck
  module Checker
    class Konacha < Base

      def run
        run_command 'rake konacha:run'
      end

      def short_message
        summary = check_output[/\d+ examples, \d+ failed, \d+ pending/, 0]
        if summary
          "with " + summary
        else
          ""
        end
      end

    end
  end
end
