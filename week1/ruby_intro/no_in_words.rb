module InWords
    def in_words
        numerals = ["","one","two","three","four","five","six","seven","eight","nine"]
        tens = ["","ten","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"]
        teens = %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
        powers = [""," thousand"," million"," billion"," trillion"," quadrillion"," quintillion"," sextillion"," septillion"," octillion"," nonillion"," decillion"," undecillion"," duodecillion"," tredecillion"," quattuordecillion"," quindecillion"," sexdecillion"," septendecillion"," octodecillian"," novemdecillion"," vigintillion"]
        result = []
        counter = 0
        negative = false

        #easter eggs and zero go here
        case self
          when 1010102050
            "Rack City bitch, Rack Rack City bitch."
          when 0
            "zero"
          else

          #is this number negative? if so, drop the "-" from the digits array
          if self.to_s.include?("-")
            negative = true
            digits = self.to_s.split("").drop(1)
          else
            digits = self.to_s.split("")
          end

          #big loop. we are popping out the digits three at a time, so it runs until there are no more
          while digits.length > 0
            block_string = ""
            block = digits.pop(3)

            #this figures out what the last two digits are
            if block[-2] == "0"
              last_two = tens[block[-2].to_i] + numerals[block[-1].to_i]
            elsif block[-2] == "1"
              last_two = teens[block[-1].to_i]
            elsif block[-1] == "0"
              last_two = tens[block[-2].to_i]
            else
              last_two = tens[block[-2].to_i] + " " + numerals[block[-1].to_i]
            end

            #this figures out what the 3 digit block string is
            block_string = case block.length
              when 3
                if block[0]  == "0"
                  last_two 
                elsif block[1,2] == ["0","0"]
                  numerals[block[0].to_i] + " hundred" + last_two
                else
                  numerals[block[0].to_i] + " hundred " + last_two
                end  
              when 2
                last_two
              when 1
                numerals[block[0].to_i]
            end
            #this shovels the block string into the result
            (result << block_string + powers[counter]) unless block_string == ""
            counter += 1
          end

          #append negative if needed, otherwise reverse and join
          if negative == true
            "negative " + result.reverse.join(" ")
          else
            result.reverse.join(" ")
          end
        end
    end
end

class Integer
    include InWords
end