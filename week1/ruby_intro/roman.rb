class Integer
  def roman(arr=[])
    numerals = { 0  =>  "",
                 1  =>  "I",
                 2  =>  "II",
                 3  =>  "III",
                 4  =>  "IV",
                 5  =>  "V",
                 6  =>  "VI",
                 7  =>  "VII",
                 8  =>  "VIII",
                 9  =>  "IX"}
    if self > 50
      raise "Number should be less than 50"
    elsif 
      self / 10 == 0
      arr << numerals[self%10]
    else
      puts "starting roman"
      arr << (self/10).roman.gsub("V","L").gsub("I","X")
      puts "starting roman ones"
      arr << (self%10).roman
    end
    puts "joining array"
    arr.join
  end
end

puts 40.roman