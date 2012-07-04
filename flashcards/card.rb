module FC
  class Card
    attr_reader :word, :definition, :hint
    def initialize(word,definition)
      @word = word
      @definition = definition
      @hint = @word[0]
    end
  end
end