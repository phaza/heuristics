# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heuristics/version'

Gem::Specification.new do |gem|
  gem.name          = "heuristics"
  gem.version       = Heuristics::VERSION
  gem.authors       = ["Peter Haza"]
  gem.email         = ["peter.haza@gmail.com"]
  gem.description   = %q{This gem allows you to define a set of conditions and test values against them.}
  gem.summary       = %q{This gem allows you to define a set of conditions and test values against them.}
  gem.homepage      = ""
	
	gem.add_development_dependency "rake"
	gem.add_development_dependency "chronic"
	gem.add_dependency "docile"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
	
end
