require './card.rb'

module Flashcards
  class Player
    attr_reader :cards

    def initialize(filename)
      @filename = filename
      @cards = []
      self.create_cards!
    end

    def play
        @current_card = self.pick_random
        self.print_definition
        @input = self.prompt
        self.evaluate
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
      @cards[rand(0..@cards.length-1)]
    end

    def print_definition
      puts "\nDefinition\n----------------\n#{@current_card.definition}"
    end

    def prompt
      printf "What am I talking about?"
      gets.chomp
    end

    def evaluate
      if @input == @current_card.term
        puts "Correct"
      end
    end



  end
end
