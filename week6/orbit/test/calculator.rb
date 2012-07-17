require './expression.rb'

module AdvancedCalculator
  class Calculator
    attr_reader :postfix, :prefix
    def initialize
    end
    
    def evaluate(input)
      stack = []
      new_expression = Expression.new(input)
      new_expression.tokens.each do |e|
        if e.class == Symbol
          stack << stack.pop.send(e,stack.pop)
        else
          stack << e
        end
      end
      stack[0]
    end
    alias :evaluate_postfix :evaluate
    alias :evaluate_prefix :evaluate
    
    def to_postfix
      
    end
    
    def to_prefix
      
    end

  end
end