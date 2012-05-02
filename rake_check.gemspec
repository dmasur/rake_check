# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rake_check/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dominik Masur"]
  gem.email         = ["dominik.masur@googlemail.com"]
  gem.description   = %q{Checking the Project for Code Smells and bad documentation}
  gem.summary       = %q{Checking the Project for Code Smells and bad documentation}
  gem.homepage      = "https://github.com/TBAA/rake_check"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rake_check"
  gem.require_paths = ["lib"]
  gem.version       = RakeCheck::VERSION
  
  gem.add_dependency "rspec"
  gem.add_dependency "colored"
  gem.add_dependency "rake"
  gem.add_dependency "reek"
  gem.add_dependency "yard"
  gem.add_dependency "rails_best_practices"
  gem.add_dependency "cane"
  gem.add_dependency 'redcarpet'
end
