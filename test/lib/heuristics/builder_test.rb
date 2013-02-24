require_relative '../../test_helper'

describe Heuristics::Builder do
  it 'should respond to #tests' do
		Heuristics::Builder.new.must_respond_to :assumptions
  end
	
	it 'must allow setting a default assumption' do
		b = Heuristics::Builder.new
		b.assume_default :string
		b.default.must_equal :string
	end
end