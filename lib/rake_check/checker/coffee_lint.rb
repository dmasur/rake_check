require 'colored'
##
# CoffeeLint Checker looks for smells in your Coffeescript code
#
# @author dmasur
module RakeCheck
  module Checker
    class CoffeeLint < Base

      def run
        run_command "coffeelint -r #{config_file.to_s} --color --quiet ."
      end

      def short_message
        "with " + check_output[/\d+ errors and \d+ warnings in \d+ files/, 0]
      end

      def config_file
        default = "clint_config.json"
        File.exists?(default) ? "--file #{default}" : nil
      end
    end
  end
end