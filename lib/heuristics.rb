require 'docile'
require 'heuristics/builder'
require 'heuristics/condition_evaluator'
require 'heuristics/tester'
require 'heuristics/version'

module Heuristics	
	class << self
		@@testers = {}
		
		def define(name, &block)
			raise "A heuristic with the name '#{name}' already exists" unless @@testers[name].nil?
			@@testers[name] = Tester.new(Docile.dsl_eval(Builder.new, &block))
		end
		
		def test(name, value)
			unless @@testers.key? name
				raise "Heuristic named #{name} hasn't been defined."
			else
				@@testers[name].test(value)
			end
		end
		
	end
end
