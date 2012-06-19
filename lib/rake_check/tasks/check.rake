# encoding: UTF-8
require 'rake_check/rbp_checker'
require 'rake_check/rspec_checker'
require 'rake_check/reek_checker'
require 'rake_check/yard_checker'
require 'rake_check/cane_checker'
require 'rake_check/cucumber_checker'
require 'rake_check/brakeman_checker'
##
# Do exakt what it is called
#
# @param [String] string The string to print
# @author dmasur
def puts_unless_empty string
  puts string unless string.empty?
end

##
# Print the check results
#
# @param [Array / Hash] results Array of Results or Hashresult
# @author dmasur
def print_check_result results
  print_outputs results
  print_summary results
end

##
# Print Outputs of each result
#
# @author dmasur
def print_outputs results
  results.each do |result|
    puts_unless_empty result[:check_output]
  end
end

##
# Print Summary of all Outputs
#
# @author dmasur
def print_summary results
  results.each do |result|
    puts "#{result[:type]}:\t#{result[:status]}"
  end
end

desc "Check all Metric tools"
task :check do
  results  ||= []
  results << CucumberChecker.new.result
  Dir["spec*"].each do |spec_dir|
    results << RspecChecker.new.result(spec_dir)
  end
  results << RbpChecker.new.result
  results << YardChecker.new.result
  results << ReekChecker.new.result
  results << CaneChecker.new.result
  results << BrakemanChecker.new.result
  print_check_result results
end
