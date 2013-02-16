require 'colored'
module RakeCheck
  module Checker
    ##
    # Check the output of rails best pratices gem
    class Rbp < Base
      def type
        "Rails best practices"
      end

      def short_message
        warnings = @check_output[/Found (\d)+ warnings/, 1]
        if warnings
          "with #{warnings} warnings"
        else
          ""
        end
      end

      def run
        run_command "rails_best_practices --silent --spec"
      end

    end
  end
end