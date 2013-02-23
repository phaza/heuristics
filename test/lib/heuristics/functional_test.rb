require_relative '../../test_helper'

describe Heuristics do	
	it 'should allow to use external libs for testing' do
		require 'chronic'
		Heuristics.define(:external_lib_test) { assume(:date) { condition { Chronic.parse(value) != nil } } }
		Heuristics.test(:external_lib_test, '23.09.85').must_equal :date
	end
	
	it 'should return the assumption that first matched all conditions' do
		require 'chronic'
		Heuristics.define(:first_come_first_serve) do
			assume_default nil # This is implicit anyway
			
			assume(:date) { condition { Chronic.parse(value) != nil } } 
			assume(:integer_string) { condition { value =~ /\A\d+\Z/ } }
			assume(:string) { condition { value.instance_of? String } } 
		end

		Heuristics.test(:first_come_first_serve, '23.09.85').must_equal :date
		Heuristics.test(:first_come_first_serve, '27').must_equal :integer_string
		Heuristics.test(:first_come_first_serve, 'This is string').must_equal :string
	end
	
	it 'should return default if no assumptions are true' do
		Heuristics.define(:default_test) { assume_default :string; assume(:email) { condition { false } } }
		Heuristics.test(:default_test, 1).must_equal :string
	end
	
	it 'should return nil if no default is set' do
		Heuristics.define(:default_test2) { assume(:nothing) { condition { false } } }
		Heuristics.test(:default_test2, 1).must_be :nil?
	end
	
	it 'should return the first true assumption' do
		Heuristics.define(:assumption_test) do 
			assume_default :integer
			assume(:string)	{ condition { value.instance_of? String } }
			assume(:hash)		{ condition { value.instance_of? String } }
		end
		Heuristics.test(:assumption_test, 'abc').must_equal :string
	end
	
	it 'should support complex types' do
		Heuristics.define(:complex_test) { assume_default :integer; assume(:test) { condition { value[:hepp] } } }
		Heuristics.test(:complex_test, Object.new).must_equal :integer
	end
	
	it 'should determine the most frequent type of an array' do
		require 'chronic'
		
		Heuristics.define(:array_test) do 
			assume(:date) { condition { Chronic.parse(value) } }
			assume(:string) { condition { value.instance_of? String } } 
			assume(:integer) { condition { value.instance_of? Fixnum } }
		end
		
		Heuristics.test(:array_test, [1,2,3,'a','b','c','d']).must_equal :string
		Heuristics.test(:array_test, [1,2,'a','b','c','23.09.85','23.09.85','23.09.85','23.09.85']).must_equal :date
	end
	
	it 'should raise an exception if trying to create a heuristic with a name that already exists ' do
		proc {
			Heuristics.define(:duplicate_heuristic_test) { assume_default :integer }
			Heuristics.define(:duplicate_heuristic_test) { assume_default :integer }
			}.must_raise RuntimeError
	end
	
	it 'should raise an exception if trying to create an assumption with a name that already exists' do
		proc { 
			Heuristics.define(:duplicate_assumption_test) do 
				assume_default :integer
				assume(:test) { condition { true } }
				assume(:test) { condition { true } }
			end
		}.must_raise RuntimeError
	end
	
end