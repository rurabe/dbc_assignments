module AdvancedCalculator
  class Operation
    attr_reader :element1, :element2, :operand, :prefix, :postfix
    def initialize(element1,element2,operand)
      @element1 = element1
      @element2 = element2
      @operand = operand
      @prefix = to_prefix
      @postfix = to_postfix
    end
    
    def to_prefix
      "#@operand #@element1 #@element2"
    end
    
    def to_postfix
      "#@element1 #@element2 #@operand"
    end
  
  end
end