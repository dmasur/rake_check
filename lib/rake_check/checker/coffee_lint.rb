require 'colored'
module RakeCheck
  module Checker
    ##
    # CoffeeLint Checker looks for smells in your Coffeescript code
    class CoffeeLint < Base
      def run
        run_command "coffeelint -r #{config_file.to_s} --color --quiet ."
      end

      def short_message
        @short_message ||= "with " +
          check_output[/\d+ errors and \d+ warnings in \d+ files?/, 0].to_s
      end

      def config_file
        default = "clint_config.json"
        File.exists?(default) ? "--file #{default}" : nil
      end
    end
  end
end