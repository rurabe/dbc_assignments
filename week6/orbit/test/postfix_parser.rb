module AdvancedCalculator
  class PostfixParser
    def initialize
    end
  
    def parse(expression)
      array = expression.split(" ")
      convert_to_sym_and_float(array)
    end
  
    private
  
    def convert_to_sym_and_float(array)
      array.map! do |e|
        e =~ /\d/ ? e.to_f : e.to_sym
      end
    end 
  end
end