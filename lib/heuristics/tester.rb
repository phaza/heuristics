module Heuristics
	class Tester
		def initialize(builder)
			@builder = builder
		end
		
		def test(value)
			freq = Frequency.new
			[*value].map do |v|
				freq.add(@builder.tests.map{|k, e| e.check(v) ? k : nil }.reject(&:nil?).first || @builder.default)
			end
			
			freq.list.keys.first
		end
		
		private
		class Frequency
			def initialize()
				@storage = {}
			end
			
			def add(name)
				@storage[name] ||= 0
				@storage[name] += 1
			end
			
			def list
				Hash[@storage.sort_by{|key, value| value }.reverse]
			end
		end
	end
end