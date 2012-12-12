require 'rake'
require 'benchmark'
require 'rake_check/result'

module RakeCheck
  class Executor
    def initialize(silent = !Rake.verbose)
      @silent = silent
      @checks = []
    end

    def add_checker(checker)
      @checks << checker
    end

    def print(*args)
      STDOUT.print *args unless @silent
    end

    def puts(*args)
      STDOUT.puts *args unless @silent
    end

    def size
      @checks.size
    end

    def execute
      check_result = RakeCheck::Result.new

      @checks.each_with_index do |checker, index|
        print "[#{index + 1}/#{size}] Testing #{checker.type} "
        check_result.run checker
        puts checker.status
      end
      if check_result.failed?
        check_result.each do |checker|
          next if checker.success?
          puts "==================================OUTPUT FOR: #{checker.type}==================================".yellow
          # puts [checker.type, checker.status].join(" ")
          puts checker.check_output
        end
        exit 1
      end
    end
  end
end