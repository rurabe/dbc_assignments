class Calculator
  def initialize

  end
  
  def evaluate_prefix(string)
    @calc_array = string.split(" ")
    while @calc_array.find {|n| n=~ /[\+\-\*\/]/ }.nil? == false
      operator_index = find_next_calculation(@calc_array)
      result = evaluate(@calc_array[operator_index],@calc_array[operator_index + 1],@calc_array[operator_index + 2])
      replace(operator_index,result)
    end
  end
  
  
  private
  
  def find_next_calculation(calc_array)
    string = calc_array.join(" ")
    next_calc_index = string.rindex(/[\+\-\*\/] \d* \d*/)
    matched_elements = string[next_calc_index..-1].split(" ")[0..2]
    @calc_array.each_index do |i|
      if @calc_array[i] == matched_elements[0] && @calc_array[i+1] == matched_elements[1] && @calc_array[i+2] == matched_elements[2]
        @match = i
      end
    end
    @match
  end
  
  #Need to double check the order, but just going to put this down
  def evaluate(operand,num1,num2)
    case operand
    when "+"
      num1 + num2
    when "-"
      num1 - num2
    when "*"
      num1 * num2
    when "/"
      num1 / num2
    end
  end
  
  def replace(index,result)
    @calc_index.delete_at(index)
    @calc_index.delete_at(index+1)
    @calc_index.delete_at(index+2)
    @calc.insert(index,result)
  end

end

