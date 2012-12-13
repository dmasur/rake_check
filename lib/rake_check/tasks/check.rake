# encoding: UTF-8
require 'rake_check'

desc "Check all Metric tools"
task :check do
  executor = RakeCheck::Executor.new
  executor.add_checker(RakeCheck::Checker::Cucumber.new)
  Dir['spec*'].each do |directory|
    executor.add_checker(RakeCheck::Checker::Rspec.new(directory: directory))
  end
  executor.add_checker(RakeCheck::Checker::Rbp.new)
  executor.add_checker(RakeCheck::Checker::Yard.new)
  executor.add_checker(RakeCheck::Checker::Reek.new)
  executor.add_checker(RakeCheck::Checker::Cane.new)
  executor.add_checker(RakeCheck::Checker::Brakeman.new)
  executor.add_checker(RakeCheck::Checker::CoffeeLint.new)
  executor.add_checker(RakeCheck::Checker::Konacha.new)
  executor.execute
end