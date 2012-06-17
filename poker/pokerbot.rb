#Pokerbot

#in texas hold-em, each player is dealt two cards (from a deck of 52) which are hidden from everyone else. then, 5 "community" cards are dealt face up in the middle of the table. these cards can be used by any player to make the strongest 5 card hand.

#write a function that takes two arrays-- one that describes your two "hole" cards, and another that describes the five community cards-- and determine your odds of winning the hand against another single player (ie. another player with two of the remaining 45 cards selected at random).

@hand =  [{"name"=>7, "suit"=>"Spade", "value"=>7, "string"=>"5 of Clubs"},
         {"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Hearts"}]
		
@board = [{"name"=>6, "suit"=>"Spade", "value"=>6, "string"=>"5 of Spades"},
		     {"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Spades"},
		     {"name"=>"Jack", "suit"=>"Spade", "value"=>11, "string"=>"Jack of Diamonds"},
	       {"name"=>5, "suit"=>"Spade", "value"=>5, "string"=>"5 of Hearts"},
		     {"name"=>"King", "suit"=>"Heart", "value"=>13, "string"=>"King of Diamonds"}]
		     
def best_hand(hand,board)
  @all_cards = hand + board
  
  counts_of_values(hand,board)
  counts_of_suits(hand,board)
  
  #four of a kind -- WORKING
  if @counts_of_values.values.include?(4)
    @quads = @counts_of_values.key(4)
  end
  
  #best trips -- WORKING
  if @counts_of_values.values.include?(3)
    @trips = []
    counts_temp = @counts_of_values
    counts_keys = counts_temp.keep_if {|value,count| count == 3 }.keys.sort
    counts_keys.size.times do
      @trips << counts_keys.pop
    end
  end
  
  #pairs -- WORKING
  if @counts_of_values.values.include?(2)
    @pairs = []
    counts_temp = @counts_of_values
    counts_keys = counts_temp.keep_if {|value,count| count == 2 }.keys.sort
    counts_keys.size.times do
      @pairs << counts_keys.pop
    end
  end
  
  #flush -- NEEDS WORK
  if @counts_of_suits.values.sort[-1] > 4
    @flush_suit = @counts_of_suits.values.sort[-1]
    @flush_values = []
    @all_cards.each do |h|
      if h["suit"] = @flush_suit
        @flush_values << h["value"]
        print @flush_values
      end
    end
    @flush_values
  end
  
  
end
    

def counts_of_values(hand,board)
  @values = []
 
  (0..1).each do |h|
    @values << hand[h]["value"]
  end
 
  (0..4).each do |b|
    @values << board[b]["value"]
  end
 
  @counts_of_values = {}
  @values.uniq.each do |value|
    @counts_of_values[value] = @values.count(value)
  end
  @counts_of_values
end

def counts_of_suits(hand,board)
  @suits = []
  
  (0..1).each do |h|
    @suits << hand[h]["suit"]
  end
 
  (0..4).each do |b|
    @suits << board[b]["suit"]
  end
  
  @counts_of_suits = {}
  @suits.uniq.each do |suit|
    @counts_of_suits[suit] = @suits.count(suit)
  end
  @counts_of_suits
end
		
