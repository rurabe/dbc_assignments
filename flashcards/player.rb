require './card.rb'

module Flashcards
  class Player
    attr_reader :cards

    def initialize(filename)
      @filename = filename
      @cards = []
      self.create_cards!
      self.play
    end

    def play
      @input = ""
      while @input != 'q'
        self.pick_random
        self.print_definition
        self.prompt("What Ruby concept am I talking about?:")
        self.evaluate

      end
    end

    def make_card(term,definition)
      @cards << Card.new(term,definition)
    end

    def import
      IO.readlines(@filename)
    end

    def parse_cards
      self.import.collect do |line|
        line.chomp.split("\t")
      end
    end

    def create_cards!
      self.parse_cards.each do |line|
        make_card(line[0],line[1])
      end
    end

    def pick_random
      @current_card = rand(0..@cards.length-1)
    end

    def print_definition
      puts "\nDefinition\n----------------\n#{@cards[@current_card].definition}"
    end

    def prompt(prompt_string)
      printf "\n#{prompt_string}"
      @input = gets.chomp
    end

    def evaluate
    guesses = 0
      while guesses < 2 && @input != 'q'
        if @input == @cards[@current_card].term
          puts "\nCorrect!  Hit enter to continue"
          gets
          guesses = 3
          return
        elsif (@input != @cards[@current_card].term)
          printf "\nTry Again..."
          @input = gets.chomp
          guesses += 1
        end
      end
      puts "Actually, it's #{@cards[@current_card].term}. Hit enter to continue"
      gets
    end
  end
end
@the_player = Flashcards::Player.new('./words.txt')