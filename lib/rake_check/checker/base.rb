require 'open3'
require 'colored'

module RakeCheck
  module Checker
    class Base
      attr_reader :check_output, :time, :options
      def initialize(options = {})
        @options = options
      end

      def status
        "(#{@time} sec): " + (success? ? "OK".green : "FAILED".red) + " " + short_message
      end

      def success?
        @status && @status.success?
      end

      # nothing by default
      def short_message
        ""
      end

      # overwrite if needed
      def type
        self.class.name.split("::").last
      end

      private
      def run_command(*commands)
        @time = Benchmark.measure do
          @check_output, @status = Open3.capture2e *commands
        end.total.round(2)
      end
    end
  end
end