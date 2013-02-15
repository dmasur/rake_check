##
# CaneChecker checks the output code smells with cane
#
# @author dmasur
module RakeCheck
  module Checker
    class Cane < Base

      def run
        run_command 'cane'
      end

      def short_message
        @short_message ||= begin
          if violations_count > 0
            violations = case violations_count
            when 0
              violations_count.to_s.green
            when 1..9
              violations_count.to_s.yellow
            else
              violations_count.to_s.yellow
            end
            "with #{violations} Violations"
          end
        end
      end

      def success?
        super && violations_count < 10
      end

      def violations_count
        (check_output[/Total Violations: (\d+)/, 1] || 0).to_i
      end
    end
  end
end