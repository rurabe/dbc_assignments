class RPNCalculator
  def initialize
    @calculator = []
  end
  
  def push(new_number)
    @calculator << new_number
  end
  
  def plus
    @calculator << @calculator.pop + @calculator.pop
  end
  
  def minus
    @calculator << -@calculator.pop + @calculator.pop
  end
  
  def times
    @calculator << @calculator.pop * @calculator.pop
  end
  
  def divide
    @calculator << 1 / @calculator.pop.to_f * @calculator.pop.to_f
  end
  
  def value
    @calculator[-1]
  end
end