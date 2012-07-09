#Ryan Urabe
#Assessment
#6/26/2012


#Exercise 1 ----------

  def new_cat(string1,string2)
    string1 + string2
  end

new_cat("Ryan","Urabe")


#Exercise 2 ----------
  
  def sum(integers)
    integers.inject(&:+)
  end
  
  
#Exercise 3 ----------
  
  #The element stored at index 3 is the string "best". 
  #The string "ruby" is at index 0.
  #The array's length is 7.
  
  
#Exercise 4 ----------
  
  def fun_string!(string)
    string.replace(string.split("").inject("") {|r,l| r.length.even? ? r + l : r + l.capitalize}.reverse)
  end
  
  
#Exercise 5 ----------

  def fizzblam
    (1..100).each do |i|
      if i % 35 == 0
        puts "FizzBlam"
      elsif i % 7 == 0
        puts "Blam"
      elsif i % 5 == 0
        puts "Fizz"
      else
        puts i
      end
    end
  end
  
  
#Exercise 6  ----------
  
  class GuessingGame
    def initialize(answer)
      @answer = answer
      @solved = false
    end
    
    def guess(guess)
      if guess > @answer
        :high
      elsif guess < @answer
        :low
      elsif guess == @answer
        @solved = true
        :correct
      end
    end
    
    def solved?
      @solved
    end
  end
 
  
#Exercise 7 ----------
  
  # Variable Scope
  #   1. Block scope? - Variables defined within a block are only accessible 
  #      within that block. These can be used within a loop or an Enumerable
  #      to represent a counter or each element being Enumerated upon.
  #   2. Local scope - Variables defined within a method are only accessible
  #      within that method. This could also be a counter within a method, or
  #      perhaps an intermediate step variable that is not used again elsewhere
  #   3. Instance scope (@)- Instance variables are available to all instance
  #      methods for that particular instance of the class. For example, an 
  #      an instance of User might have an @name variable that can be accessed
  #      by all instance menthods. However another User will have a different 
  #      @name.
  #   4. Class scope (@@) -  Class variables are available to all instances of
  #      any particular class. For example, you might have a @@counter that
  #      counts the number of instances that have been instantiated and assigns
  #      a user id based on that number.
  #   5. Global scope ($) - Global variables are available to every method, class
  #      and instance at all times. If you were designing a program for a company
  #      you could set $company to the company name, especially if it were like a 
  #      law firm that changed when partners joined or left.


#Exercise 8 ----------

  #   1.  Array.each takes a block and performs the work specified by the block on
  #       each element in the array. The return value for Array.each is the original 
  #       array that .each was called on. If no block is passed to .each, then an 
  #       Enumerator is returned.
  #   2.  Array.map is very similar to Array.each in that it takes a block and 
  #       performs the work specified by the block on each element in the array.
  #       The difference, however, is that the return value is the new array of
  #       values modified by the block. Similarly, if no block is passed, an
  #       Enumerator is returned.
  #   3.  Array.select also takes a block, however its function is different in that
  #       its block acts as a filter, and it returns a new array which includes only
  #       the elements in the original array for which the block evaluated to true.
  #       Under the hood, the function feeds each element into the block and sees if
  #       the block evaluates to true or false. Again, if no block is passed, it
  #        returns an Enumerator.

#Exercise 9 ----------

  #   1.  This method takes each integer and prints the product of itself and 100
  #       to the console. The function returns the original array.
  #   2.  This method sets the maximum acceptable value as the first integer in the
  #       array, and sets all values greater than this to the value of the first integer. 
  #       It returns the maximum value (the first integer)
  #   3.  This method creates an array where each integer in the original array is greater
  #       by 80. It returns this +80 array.
  #   4.  This method returns an array with only the even numbers from the original array.

  def method_4(array)
    array.select(&:even?)
  end
  
  
#Exercise 10 ----------

  #   1.  Class Foo was designed such to take a number as an argument at its creation.
  #       You could either make the parameter optional with an asterisk, or instantiate
  #       it with an argument.
  #   2.  As an instance variable, @num is not visible to methods outside that 
  #       instance of the class. You could either make an accessor method to return @num
  #       or better yet, identify it as an attr_reader.
  #   3.  Similar to #2, @num is not modifiable to methods outside this instance. Since 
  #       the puts also requires read access, it would make most sense to make @num an
  #       attr_accessor instead of simply a reader.


#Exercise 11 ----------

  #       *All responses return nil
  #   1.  "woof" - because irb likes to output strings in "" form not ''. :dog is a valid key
  #   2.  nil - There is no key that is String 'dog'.
  #   3.  "meow" - There is a key that is String 'cat'. Again, "" instead of ''.
  #   4.  nil - There is no key 'quack', only a value.
  #   5.  nil - The key is String 'duck', not Symbol :duck.


#Exercise 12 ----------

  #       puts prints the results of the argument passed to it as a string on the console.
  #       It always returns the value nil, which is to say that it will never pass another
  #       function any value but nil.
  #       return explicitly defines the result of its argument as the value that should be
  #       passed to any user or method that invokes it. The last value evaluated in a method
  #       is implicitly returned by default.
  
#Exercise 13 ----------

  #       It takes slow much longer because it has to evaluate itself three times each time its
  #       invoked unless the argument is 0 or 1. Thus, the number of iterations increases 
  #       exponentially until it reaches fib_slow(1) or fib_slow(0). Fib_fast only runs once
  #       for each step in the sequence you need above 2, because it builds the array first one
  #       step at a time, then returns the value from this array.
  
  
               
               
               
               
               
               
               
               
            
  
  
  
  
  
  