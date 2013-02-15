require 'rake'
require 'benchmark'
require 'rake_check/result'

module RakeCheck
  class Executor
    include Term::ANSIColor
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
          puts white(on_blue(bold(["=" * 50, "OUTPUT FOR: ", checker.type, "=" * 50].join(""))))
          puts checker.check_output
        end
        exit 1
      end
    end
  end
end