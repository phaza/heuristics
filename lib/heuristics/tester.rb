module Heuristics
	class Tester
		def initialize(builder)
			@builder = builder
		end
		
		def test(value)
			@builder.tests.map{|k, e| e.check(value) ? k : nil }.reject(&:nil?).first || @builder.default
		end
	end
end