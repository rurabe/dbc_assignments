module Flashcards
  class Card
    attr_reader :term, :definition
    def initialize(term,definition)
      @term = term
      @definition = definition
    end

    def hint
      hint = term[0]
    end
  end
end