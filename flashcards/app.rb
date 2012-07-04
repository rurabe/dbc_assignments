require './round.rb'
require './card.rb'

module FC
  class App
    attr_reader :cards, :rounds
    def initialize
      @cards = []
      @rounds = []
      self.create_cards
    end

    def read_file
      IO.readlines('./words.txt')
    end

    def parse_file
      read_file.collect do |line|
        line.chomp.split("\t")
      end
    end

    def create_cards
      parse_file.each do |line|
        @cards << Card.new(line[0],line[1])
      end
    end

    def start
      while @input != 'n'
        @rounds << Round.new(@cards[rand(0..@cards.length-1)])
        @rounds[-1].play
        printf "Continue? y/n :"
        @input = gets.chomp
      end
    end
  end
end

x = FC::App.new
x.start