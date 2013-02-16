require 'colored'
module RakeCheck
  module Checker
    ##
    # Konacha Checker checks for konacha Errors in you Javascripttests
    class Konacha < Base
      def run
        run_command 'rake konacha:run'
      end

      def short_message
        @short_message ||= begin
          summary = check_output[/\d+ examples, \d+ failed, \d+ pending/, 0]
          if summary
            "with " + summary
          end
        end
      end

    end
  end
end
