# encoding: UTF-8
require 'rake_check/rbp_checker'
require 'rake_check/rspec_checker'
require 'rake_check/reek_checker'
require 'rake_check/yard_checker'
require 'rake_check/cane_checker'
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
    type_name = result[:type].to_s
    status = result[:status]
    puts "puts #{type_name}:\t#{status}"
  end
end
desc "Check Rails Best Practices and RSpec"
task :check do
  rspec = RspecChecker.new.result
  rbp = RbpChecker.new.result
  yard = YardChecker.new.result
  reek = ReekChecker.new.result
  cane = CaneChecker.new.result
  print_check_result [rspec, rbp, yard, reek, cane]
end
