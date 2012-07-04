module Pokerbot
  class Card
    attr_reader :name, :suit, :value, :string
    def initialize(hash)
      @name = hash["name"]
      @suit = hash["suit"]
      @value = hash["value"]
      @string = hash["string"]
    end
  end
end