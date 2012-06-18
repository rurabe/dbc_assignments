require 'rspec'
#Pokerbot

#in texas hold-em, each player is dealt two cards (from a deck of 52) which are hidden from everyone
# else. then, 5 "community" cards are dealt face up in the middle of the table. these cards can be
# used by any player to make the strongest 5 card hand.

#write a function that takes two arrays-- one that describes your two "hole" cards, and another that
#describes the five community cards-- and determine your odds of winning the hand against another 
#single player (ie. another player with two of the remaining 45 cards selected at random).

def best_hand(hand,board)
  
  cards = hand + board
  
  hands(cards)
  
  if !@straight_flush.empty?
    {:hand => :straight_flush, 
     :high => @straight_flush[-1], 
     :suit => @flush_suit}
  elsif !@quads.empty?
     kickers = []
     cards.each do |c| 
        (kickers << c["value"]) unless c["value"] == @quads[0]
      end
    {:hand => :four_of_a_kind, 
     :high => @quads[0], 
     :kickers => kickers.sort.reverse[0,1]}
  elsif @trips.size > 1 || (!@trips.empty? && !@pairs.empty?)
    fullhouse = (@trips + @pairs).sort.reject {|value| value == @trips.sort[-1] }
    {:hand => :full_house, 
     :high => @trips.sort[-1], 
     :second => fullhouse[-1]}
  elsif !@flush_values.empty?
    {:hand => :flush, 
     :values => @flush_values,
     :suit => @flush_suit}
  elsif !@straight.empty?
    {:hand => :straight, 
     :high =>@straight[-1]}
  elsif !@trips.empty?
    kickers = []
    cards.each do |c| 
      (kickers << c["value"]) unless c["value"] == @trips[-1]
    end
    {:hand => :three_of_a_kind, 
     :high => @trips[-1],
     :kickers => kickers.sort.reverse[0,2]}
  elsif @pairs.size >= 2
     kickers = []
      cards.each do |c| 
        (kickers << c["value"]) unless c["value"] == @pairs.sort[-1] || c["value"] == @pairs.sort[-2]
      end
    {:hand => :two_pair, 
     :high => @pairs.sort[-1], 
     :second => @pairs.sort[-2],
     :kickers => kickers.sort.reverse[0,1]}
  elsif @pairs.size == 1
    kickers = []
      cards.each do |c| 
        (kickers << c["value"]) unless c["value"] == @pairs[0]
      end
    {:hand => :pair, 
     :high => @pairs[0],
     :kickers => kickers.sort.reverse[0,3]}
  else
    kickers = []
      cards.each do |c| 
        (kickers << c["value"])
      end
    {:hand => :high_card,
     :kickers => kickers.sort.reverse[0,5]}
  end
end
    

def hands(cards)
  counts_of_values(cards)
  counts_of_suits(cards)


  #flush -- WORKING
  @flush_values = []
  if @counts_of_suits.values.sort[-1] > 4
    @flush_suit = @counts_of_suits.key(@counts_of_suits.values.sort[-1])
    cards.each do |h|
      if h["suit"] == @flush_suit
        @flush_values << h["value"]
      end
    end
    @flush_values = @flush_values.sort.reverse
  end
  
  
  #straight -- WORKING
  @straight = []
  i = 0
  3.times do |i|
    if @values.sort[i,5] == (@values.sort[i]..(@values.sort[i]+4)).to_a
      @straight = []
      @straight = @values.sort[i,5]
      i += 1
    end
  end
  
  #four of a kind -- WORKING
  @quads = []
  if @counts_of_values.values.include?(4)
    @quads << @counts_of_values.key(4)
  end
  
  
  #best trips -- WORKING
  @trips = []
  if @counts_of_values.values.include?(3)
    counts_keys = @counts_of_values.select {|key,value| value == 3 }.keys.sort
    counts_keys.size.times do
      @trips << counts_keys.pop
    end
  end
  
  
  #pairs -- WORKING
  @pairs = []
  if @counts_of_values.values.include?(2)
    counts_keys = @counts_of_values.select {|key,value| value == 2 }.keys.sort
    counts_keys.size.times do
      @pairs << counts_keys.pop
    end
  end


  #straight flush  -- WORKING
  @straight_flush = []
  if !@flush_values.empty? && !@straight.empty? 
    @flush_values.sort.each_index do |i|
      if @flush_values.sort[i+1].to_i - @flush_values.sort[i].to_i == 1
        @straight_flush << @flush_values.sort[i]
      end
    end
    @straight_flush << @straight_flush[-1] + 1
    @straight_flush = @straight_flush.size > 4 ? @straight_flush : []  
  end
end
    

def counts_of_values(cards)
  @values = []
  @counts_of_values = {}
   
  (0..cards.size-1).each do |c|
    @values << cards[c]["value"]
  end

  @values.uniq.each do |value|
    @counts_of_values[value] = @values.count(value)
  end
  @counts_of_values
end



def counts_of_suits(cards)
  @suits = []
  @counts_of_suits = {}
    
  (0..cards.size-1).each do |c|
    @suits << cards[c]["suit"]
  end
  
  @suits.uniq.each do |suit|
    @counts_of_suits[suit] = @suits.count(suit)
  end
  @counts_of_suits
end


describe "best_hand" do
  it "should return straight flushes" do
    sample_hand =  [{"name"=>9, "suit"=>"Clubs", "value"=>9, "string"=>"9 of Clubs"},
                    {"name"=>"King", "suit"=>"Clubs", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>"Queen", "suit"=>"Clubs", "value"=>12, "string"=>"Queen of Clubs"},
        		        {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
        		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :straight_flush, :high => 13, :suit => "Clubs"})
  end
  it "should return four of a kind" do
    sample_hand =  [{"name"=>"King", "suit"=>"Spades", "value"=>13, "string"=>"King of Spades"},
                    {"name"=>"King", "suit"=>"Clubs", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>"Queen", "suit"=>"Clubs", "value"=>12, "string"=>"Queen of Clubs"},
        		        {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>"King", "suit"=>"Heart", "value"=>13, "string"=>"King of Hearts"},
        		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :four_of_a_kind, :high => 13, :kickers => [12]})
  end
  it "should return full houses" do
    sample_hand =  [{"name"=>"King", "suit"=>"Spades", "value"=>13, "string"=>"King of Spades"},
                    {"name"=>"King", "suit"=>"Clubs", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>10, "suit"=>"Spades", "value"=>10, "string"=>"10 of Spades"},
        		        {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>10, "suit"=>"Heart", "value"=>10, "string"=>"10 of Hearts"},
        		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :full_house, :high => 13, :second => 10})
  end
  it "should return flushes" do
    sample_hand =  [{"name"=>7, "suit"=>"Clubs", "value"=>7, "string"=>"7 of Clubs"},
                    {"name"=>"King", "suit"=>"Clubs", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>"Queen", "suit"=>"Clubs", "value"=>12, "string"=>"Queen of Clubs"},
        		        {"name"=>4, "suit"=>"Clubs", "value"=>4, "string"=>"4 of Clubs"},
        	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
        		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :flush, :values => [13,12,10,7,4], :suit => "Clubs"})
  end
  it "should return straights" do
    sample_hand =  [{"name"=>9, "suit"=>"Diamonds", "value"=>9, "string"=>"9 of Diamonds"},
                    {"name"=>"King", "suit"=>"Clubs", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
     		            {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
         		        {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
         	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
         		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
     best_hand(sample_hand,sample_board).should eq({:hand => :straight, :high => 13})
   end
   it "should return trips" do
    sample_hand =  [{"name"=>"King", "suit"=>"Spades", "value"=>13, "string"=>"King of Diamonds"},
                    {"name"=>"King", "suit"=>"Clubs", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
      		          {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
    		            {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
        		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
      best_hand(sample_hand,sample_board).should eq({:hand => :three_of_a_kind, :high => 13, :kickers => [12,11]})
    end  
    it "should return two pair" do
      sample_hand =  [{"name"=>2, "suit"=>"Spades", "value"=>2, "string"=>"2 of Diamonds"},
                      {"name"=>"Queen", "suit"=>"Clubs", "value"=>12, "string"=>"Queen of Clubs"}]
      sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
        		          {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
      		            {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
          	          {"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
          		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
        best_hand(sample_hand,sample_board).should eq({:hand => :two_pair, :high => 12, :second => 2, :kickers => [13]})
      end
    it "should return pairs" do
      sample_hand =  [{"name"=>3, "suit"=>"Spades", "value"=>3, "string"=>"3 of Diamonds"},
                      {"name"=>"Queen", "suit"=>"Clubs", "value"=>12, "string"=>"Queen of Clubs"}]
      sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
        		          {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
      		            {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
          	          {"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
          		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
        best_hand(sample_hand,sample_board).should eq({:hand => :pair, :high => 12, :kickers => [13,11,10]})
    end        
    it "should return a high card" do
      sample_hand =  [{"name"=>3, "suit"=>"Spades", "value"=>3, "string"=>"3 of Diamonds"},
                      {"name"=>"Queen", "suit"=>"Clubs", "value"=>12, "string"=>"Queen of Clubs"}]
      sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
        		          {"name"=>7, "suit"=>"Heart", "value"=>7, "string"=>"7 of Hearts"},
      		            {"name"=>"Jack", "suit"=>"Clubs", "value"=>11, "string"=>"Jack of Clubs"},
          	          {"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
          		        {"name"=>10, "suit"=>"Clubs", "value"=>10, "string"=>"10 of Clubs"}]
        best_hand(sample_hand,sample_board).should eq({:hand => :high_card, :kickers => [13,12,11,10,7]})
    end
end
    