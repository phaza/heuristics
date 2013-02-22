require 'ostruct'

module Heuristics
	class ConditionEvaluator		
		
		def initialize
			@conditions = []
		end
		
		def condition(&block)
			@conditions << Proc.new(&block)
		end
		
		def check(value)
			context = OpenStruct.new(value: value)
			
			@conditions.map{|cond| context.instance_eval(&cond) rescue false}.reject{|v| v}.length == 0
		end
	end
end
