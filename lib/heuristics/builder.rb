require 'ostruct'

module Heuristics
	class Builder
		attr_reader :assumptions, :default
		
		def initialize
			@assumptions = {}
		end
		
		def assume(type, &block)
			raise "An assumption with the name '#{type}' already exists" unless @assumptions[type].nil?
			@assumptions[type] = Proc.new(&block)
		end
		
		def check(value)
			context = OpenStruct.new(value: value)
			
			@assumptions.map do |type, prok|
				(context.instance_eval(&prok) ? type : default) rescue default
			end.reject(&:nil?).first
		end
		
		def assume_default(type)
			@default = type
		end
	end 
end
