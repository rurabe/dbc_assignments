module FC
  class Round
    def initialize(card)
      @card = card
      @guesses = []
      @solved = nil
    end

    def display
      puts @card.definition
    end

    def ask
      printf "Do you know what I'm talking about?:"
      @guesses << gets.chomp
    end

    def evaluate
      if @guesses[-1] == @card.word
        puts "Correct!"
        @solved = Time.now
      elsif @guesses.length == 3
        puts "Ah, it was #{@card.word}"
      else
        puts "Nope, try again:"
      end
    end

    def play
      display
      while @guesses.length < 3 && @solved == nil
        ask
        evaluate
      end
    end
  end
end