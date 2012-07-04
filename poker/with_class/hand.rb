require File.expand_path("../card.rb", __FILE__)

module Pokerbot
  class Hand
    attr_reader :hole_cards, :board_cards, :all_cards
    def intialize(hole_cards,board_cards)
      @hole_cards = []
      @board_cards = []
      @all_cards = @hole_cards+@board_cards
      self.populate_cards(hole_cards,board_cards)
    end
    
    def populate_cards(hole_array,board_array)
      hole_array.each do |card_info|
        @hole_cards << Pokerbot::Card.new(card_info)
      end
      
      board_array.each do |card_info|
        @board_cards << Pokerbot::Card.new(card_info)
      end
    end
      
    def count_values
      @all_cards
    end
      
      
  end
end