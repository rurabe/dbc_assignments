class RPNCalculator
  
  def initialize
    @calculator = []
  end
  
  def push(new_number)
    @calculator << new_number
  end
  
  def plus
    if @calculator.empty?
      raise "calculator is empty"
    else
    @calculator << @calculator.pop + @calculator.pop
    end
  end
  
  def minus
    if @calculator.empty?
      raise "calculator is empty"
    else
    @calculator << -@calculator.pop + @calculator.pop
    end
  end
  
  def times
    if @calculator.empty?
      raise "calculator is empty"
    else
    @calculator << @calculator.pop * @calculator.pop
    end
  end
  
  def divide
    if @calculator.empty?
      raise "calculator is empty"
    else
    @calculator << 1 / @calculator.pop.to_f * @calculator.pop.to_f
    end
  end
  
  def tokens(string)
    array = string.split(" ")
    token_array = []
    array.each do |e|
      if e =~ /\d/
        token_array << e.to_i
      else
        token_array << e.to_sym
      end
    end
    token_array
  end
  
  def evaluate(string)
    token_array = tokens(string)
    token_array.each do |e|
      if e.to_s =~ /\d/
        push(e)
      elsif e == :+
        plus
      elsif e == :-
        minus
      elsif e == :*
        times
      elsif e == :/
        divide
      end
    end
    value
  end
  
  def value
    @calculator[-1]
  end
end