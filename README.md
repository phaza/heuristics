# Heuristics

This gem allows you to define a set of conditions and test values against them.
A typical simple example can look like this:

    require 'chronic'
    Heuristics.define(:field_tester) do
    	assume_default :integer
	
    	assume(:date) { condition { Chronic.parse(value) } }
    	assume(:string) { condition { value.instance_of? String } }
    	assume(:hash) { condition { value.instance_of? Hash } } 
    end

Then you can use it like this

    # Returns :string
    Heuristics.test(:field_tester, 'abc')

    # Returns :date
    Heuristics.test(:field_tester, '23.09.1985')

    # Falls back to :integer per assume_default. None of the other assumptions returned trus
    Heuristics.test(:field_tester, [])



## Installation

Add this line to your application's Gemfile:

    gem 'heuristics'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heuristics

## Usage

**NOTE**: Order matters. First assumption to return true for all conditions will be used.
This means you should write your assumptions in the order from most specific to least specfic.

    # Creates a new heuristic named :field_tester
    Heuristics.define(:field_tester) do
    
      # Default value to return if no assumptions match
      assume_default :integer

      # Assummption with multiple conditions. Returns :hash_with_values
      # if all conditions return true
      assume(:hash_with_values)		do
        condition { value.instance_of? Hash }
        condition { value.keys.size > 0 }
      }

      # An assumption that will return :date if all conditions return true
      assume(:date) { condition { Chronic.parse(value) != nil } }
      
      # An assumption that will return :string if all conditions return true
      assume(:string)	{ condition { value.instance_of? String } }
    end
    
    
    # Test a value against heuristic named :field_tester
    # First assumption to test true for all conditions will win
    # Returns :hash_with_values in this case
    Heuristics.test(:field_tester, {a: 1})
    
**Test an array of value** (Also shows of using heuristic without a name):
  Heuristics.define do
    
    # Default value to return if no assumptions match
    assume_default :set

    assume(:date) { condition { Chronic.parse(value) != nil } }
    assume(:string)	{ condition { value.instance_of? String } } }
    assume(:integer)	{ condition { value.instance_of? Fixnum } }} 
  end
    
  Heuristics.test([1,2,3,'23.09.85','1','2','3','4']) # returns :string

    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
