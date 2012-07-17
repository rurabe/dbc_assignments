require './postfix_parser.rb'
require './prefix_parser.rb'

module AdvancedCalculator
  class Expression
    attr_reader :string, :notation, :tokens, :prefix, :postfix
    def initialize(expression)
      @postfix = PostfixParser.new
      @prefix = PrefixParser.new
      @string = expression
      @notation = detect_notation(expression)
      @tokens = parse(expression,@notation)
    end
    
    private
    
    def detect_notation(expression)
      if expression[0] =~ /[\+\-\*\/]/
        :prefix
      elsif expression[0] =~ /\d/
        :postfix
      else
        nil
      end
    end
    
    def parse(expression,notation)
      send(notation).parse(expression)
    end
    
  end
end