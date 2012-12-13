require 'colored'
##
# YardChecker checks the output for undocumented classes and methods
#
# @author dmasur
module RakeCheck
  module Checker
    class Yard < Base

      def run
        run_command 'yard'
      end

      def short_message
        colored = case percentage
        when 0..80
          red "#{percentage}%"
        when 80..90
          yellow "#{percentage}%"
        when 90..100
          green "#{percentage}%"
        end
        colored + " documented"
      end

      def percentage
        check_output[/(\d+\.\d+)% documented/, 1].to_f
      end

      def success?
        percentage > 80
      end
    end
  end
end