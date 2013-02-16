require 'term/ansicolor'
require 'open3'
require 'Benchmark'

module RakeCheck
  module Checker
    ##
    # Abstractclass for all Checker
    class Base
      include Term::ANSIColor

      attr_reader :check_output, :time, :options, :short_message
      def initialize(options = {})
        @options = options
      end

      def status
        "(#{@time} sec): " + (success? ? "OK".green : "FAILED".red) + " " + short_message.to_s
      end

      def success?
        @status && @status.success?
      end

      # overwrite if needed
      def type
        self.class.name.split("::").last
      end

      private

      def handle_error(e)
        @status = OpenStruct.new(success?: false)
        @short_message = e.message
        @check_output = e.backtrace.unshift('Backtrace:'.bold.cyan).
          unshift("Error: ".bold.red + e.message).join("\n")
      end

      def run_command(*commands)
        @time = Benchmark.measure do
          begin
            @check_output, @status = Open3.capture2e *commands
          rescue Errno::ENOENT => e
            handle_error(e)
          end
        end.total.round(2)
      end
    end
  end
end
