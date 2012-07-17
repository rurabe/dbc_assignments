module AdvancedCalculator
  class PrefixParser
    def initialize
    end
  
    def parse(expression)
      postfix_notation = convert_to_postfix(expression)
      convert_to_sym_and_float(postfix_notation)

    end

    def convert_to_postfix(expression)
      array = expression.split(" ")
      array.reverse!
      array.join(" ")
    end
  
    private
  
    def convert_to_sym_and_float(expression)
      array = expression.split(" ")
      array.map! do |e|
        e =~ /\d/ ? e.to_f : e.to_sym
      end
    end 

    
  end
end