require 'colored'
module RakeCheck
  module Checker
    ##
    # YardChecker checks the output for undocumented classes and methods
    class Yard < Base
      def run
        run_command 'yard'
      end

      def short_message
        colored = case percentage
        when 0..80
          "#{percentage}%".red
        when 80..90
          "#{percentage}%".yellow
        when 90..100
          "#{percentage}%".green
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