class Book
  attr_reader :title
        
  def initialize
    @title = ""
  end

  def title=(new_title)
    @nocaps = %w(a an and as at but by en for if in of
                 on or the to via)
    title_case_words = []
    title_words = new_title.split(" ")
    title_words[0].capitalize!
    title_words.each do |word|
      if @nocaps.include?(word)
        title_case_words << word
      else
        title_case_words << word.capitalize
      end
    end
    @title = title_case_words.join(" ")
  end
end  