##
# Check the Output of rspec and simplecov
module RakeCheck
  module Checker
    class Rspec < Base

      def run
        run_command({"COVERAGE" => "true"}, "rspec --color #{directory}")
      end

      def directory
        options[:directory] || 'spec'
      end

      def short_message
        if check_output.include?('Coverage report generated')
            coverage = /LOC \(([\d.]+)%\) covered/.match(check_output)[1].to_f
            coverage = case coverage
            when 0..60
              red "#{coverage}%"
            when 60..90
              yellow "#{coverage}%"
            when 90..100
              green "#{coverage}%"
            end
            "with #{coverage} Code Coverage"
        else
          ""
        end
      end

      def type
        "RSpec " + directory
      end
    end
  end
end