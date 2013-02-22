module Heuristics
	class Builder
		attr_reader :tests, :default
		
		def initialize
			@tests = {}
		end
		
		def assume(type, &block)
			raise "An assumption with the name '#{type}' already exists" unless @tests[type].nil?
			@tests[type] = Docile.dsl_eval(ConditionEvaluator.new, &block)
		end
		
		def assume_default(type)
			@default = type
		end
	end 
end
