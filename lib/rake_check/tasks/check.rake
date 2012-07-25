# encoding: UTF-8
require 'rake_check/rbp_checker'
require 'rake_check/rspec_checker'
require 'rake_check/reek_checker'
require 'rake_check/yard_checker'
require 'rake_check/cane_checker'
require 'rake_check/cucumber_checker'
require 'rake_check/brakeman_checker'
require 'rake_check/coffee_lint_checker'
require 'rake_check/konacha_checker'
require 'benchmark'

##
# Do exakt what it is called
#
# @param [String] string The string to print
# @author dmasur
def puts_unless_empty(string)
  puts string unless string.empty?
end

##
# Print the check results
#
# @param [Array / Hash] results Array of Results or Hashresult
# @author dmasur
def print_check_result(results)
  print_outputs results
  print_summary results
end

##
# Print Outputs of each result
#
# @author dmasur
def print_outputs(results)
  results.each do |result|
    puts_unless_empty result[:check_output]
  end
end

##
# Print Summary of all Outputs
#
# @author dmasur
def print_summary(results)
  result = results.map do |result|
    "#{result[:type].to_s.capitalize}§#{result[:status]}"
  end
  puts `echo "#{result.join("\n")}" | column -t -s§`
end
def execute_checker(klass, argument=nil)
  @index += 1
  name = klass.to_s.gsub("Checker", '')
  name = [name, argument].compact.join(' ')
  print "[#{@index}/10] Testing #{name} "
  checker = klass.new
  time = Benchmark.measure do
    @results << if argument
    checker.result(argument)
    else
      checker.result
    end
  end
  print "(#{time.total.round(2)} sec): "
  puts @results.last[:status]
end
desc "Check all Metric tools"
task :check do
  @results = []
  @index = 0
  execute_checker CucumberChecker
  Dir["spec*"].each do |spec_dir|
    execute_checker RspecChecker, spec_dir
  end
  execute_checker RbpChecker
  execute_checker YardChecker
  execute_checker ReekChecker
  execute_checker CaneChecker
  execute_checker BrakemanChecker
  execute_checker CoffeeLintChecker
  execute_checker KonachaChecker
  print_check_result @results
end
