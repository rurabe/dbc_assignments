require 'rspec'
#Pokerbot

#in texas hold-em, each player is dealt two cards (from a deck of 52) which are hidden from everyone
# else. then, 5 "community" cards are dealt face up in the middle of the table. these cards can be
# used by any player to make the strongest 5 card hand.

#write a function that takes two arrays-- one that describes your two "hole" cards, and another that
#describes the five community cards-- and determine your odds of winning the hand against another 
#single player (ie. another player with two of the remaining 45 cards selected at random).
@sample_hand =  [{"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Spades"},
                {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
@sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
		            {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"},
    		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]


def best_hand(hand,*board)
  
  if board != nil
    cards = hand + board
  else
    cards = hand
  end
  
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
  (cards.length - 4).times do |i|
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
 
    
def possible_values(hand,*board)
  
  @card_index = {1	=>	{"name"=>2, "suit"=>"Club", "value"=>2, "string"=>"2 of Clubs"},
                2	=>	{"name"=>3, "suit"=>"Club", "value"=>3, "string"=>"3 of Clubs"},
                3	=>	{"name"=>4, "suit"=>"Club", "value"=>4, "string"=>"4 of Clubs"},
                4	=>	{"name"=>5, "suit"=>"Club", "value"=>5, "string"=>"5 of Clubs"},
                5	=>	{"name"=>6, "suit"=>"Club", "value"=>6, "string"=>"6 of Clubs"},
                6	=>	{"name"=>7, "suit"=>"Club", "value"=>7, "string"=>"7 of Clubs"},
                7	=>	{"name"=>8, "suit"=>"Club", "value"=>8, "string"=>"8 of Clubs"},
                8	=>	{"name"=>9, "suit"=>"Club", "value"=>9, "string"=>"9 of Clubs"},
                9	=>	{"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"},
                10	=>	{"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
                11	=>	{"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"},
                12	=>	{"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"},
                13	=>	{"name"=>"Ace", "suit"=>"Club", "value"=>14, "string"=>"Ace of Clubs"},
                14	=>	{"name"=>2, "suit"=>"Diamond", "value"=>2, "string"=>"2 of Diamonds"},
                15	=>	{"name"=>3, "suit"=>"Diamond", "value"=>3, "string"=>"3 of Diamonds"},
                16	=>	{"name"=>4, "suit"=>"Diamond", "value"=>4, "string"=>"4 of Diamonds"},
                17	=>	{"name"=>5, "suit"=>"Diamond", "value"=>5, "string"=>"5 of Diamonds"},
                18	=>	{"name"=>6, "suit"=>"Diamond", "value"=>6, "string"=>"6 of Diamonds"},
                19	=>	{"name"=>7, "suit"=>"Diamond", "value"=>7, "string"=>"7 of Diamonds"},
                20	=>	{"name"=>8, "suit"=>"Diamond", "value"=>8, "string"=>"8 of Diamonds"},
                21	=>	{"name"=>9, "suit"=>"Diamond", "value"=>9, "string"=>"9 of Diamonds"},
                22	=>	{"name"=>10, "suit"=>"Diamond", "value"=>10, "string"=>"10 of Diamonds"},
                23	=>	{"name"=>"Jack", "suit"=>"Diamond", "value"=>11, "string"=>"Jack of Diamonds"},
                24	=>	{"name"=>"Queen", "suit"=>"Diamond", "value"=>12, "string"=>"Queen of Diamonds"},
                25	=>	{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
                26	=>	{"name"=>"Ace", "suit"=>"Diamond", "value"=>14, "string"=>"Ace of Diamonds"},
                27	=>	{"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
                28	=>	{"name"=>3, "suit"=>"Heart", "value"=>3, "string"=>"3 of Hearts"},
                29	=>	{"name"=>4, "suit"=>"Heart", "value"=>4, "string"=>"4 of Hearts"},
                30	=>	{"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
                31	=>	{"name"=>6, "suit"=>"Heart", "value"=>6, "string"=>"6 of Hearts"},
                32	=>	{"name"=>7, "suit"=>"Heart", "value"=>7, "string"=>"7 of Hearts"},
                33	=>	{"name"=>8, "suit"=>"Heart", "value"=>8, "string"=>"8 of Hearts"},
                34	=>	{"name"=>9, "suit"=>"Heart", "value"=>9, "string"=>"9 of Hearts"},
                35	=>	{"name"=>10, "suit"=>"Heart", "value"=>10, "string"=>"10 of Hearts"},
                36	=>	{"name"=>"Jack", "suit"=>"Heart", "value"=>11, "string"=>"Jack of Hearts"},
                37	=>	{"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
                38	=>	{"name"=>"King", "suit"=>"Heart", "value"=>13, "string"=>"King of Hearts"},
                39	=>	{"name"=>"Ace", "suit"=>"Heart", "value"=>14, "string"=>"Ace of Hearts"},
                40	=>	{"name"=>2, "suit"=>"Spade", "value"=>2, "string"=>"2 of Spades"},
                41	=>	{"name"=>3, "suit"=>"Spade", "value"=>3, "string"=>"3 of Spades"},
                42	=>	{"name"=>4, "suit"=>"Spade", "value"=>4, "string"=>"4 of Spades"},
                43	=>	{"name"=>5, "suit"=>"Spade", "value"=>5, "string"=>"5 of Spades"},
                44	=>	{"name"=>6, "suit"=>"Spade", "value"=>6, "string"=>"6 of Spades"},
                45	=>	{"name"=>7, "suit"=>"Spade", "value"=>7, "string"=>"7 of Spades"},
                46	=>	{"name"=>8, "suit"=>"Spade", "value"=>8, "string"=>"8 of Spades"},
                47	=>	{"name"=>9, "suit"=>"Spade", "value"=>9, "string"=>"9 of Spades"},
                48	=>	{"name"=>10, "suit"=>"Spade", "value"=>10, "string"=>"10 of Spades"},
                49	=>	{"name"=>"Jack", "suit"=>"Spade", "value"=>11, "string"=>"Jack of Spades"},
                50	=>	{"name"=>"Queen", "suit"=>"Spade", "value"=>12, "string"=>"Queen of Spades"},
                51	=>	{"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Spades"},
                52	=>	{"name"=>"Ace", "suit"=>"Spade", "value"=>14, "string"=>"Ace of Spades"}}
  
  @known_hand_values = []
  @known_board_values = []
  hand.each do |h|
    @known_hand_values << @card_index.key(h)
  end
  
  if board != nil
    board.each do |b|
      @known_board_values << @card_index.key(b)
    end
  end
  
  
  @unaccounted_for_cards = @card_index.keys - @known_card_values
    
  
end

describe "best_hand" do
  it "should return straight flushes" do
    sample_hand =  [{"name"=>9, "suit"=>"Club", "value"=>9, "string"=>"9 of Clubs"},
                    {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"},
        		        {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
        		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :straight_flush, :high => 13, :suit => "Clubs"})
  end
  it "should return four of a kind" do
    sample_hand =  [{"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Spades"},
                    {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"},
        		        {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>"King", "suit"=>"Heart", "value"=>13, "string"=>"King of Hearts"},
        		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :four_of_a_kind, :high => 13, :kickers => [12]})
  end
  it "should return full houses" do
    sample_hand =  [{"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Spades"},
                    {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>10, "suit"=>"Spade", "value"=>10, "string"=>"10 of Spades"},
        		        {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>10, "suit"=>"Heart", "value"=>10, "string"=>"10 of Hearts"},
        		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :full_house, :high => 13, :second => 10})
  end
  it "should return flushes" do
    sample_hand =  [{"name"=>7, "suit"=>"Club", "value"=>7, "string"=>"7 of Clubs"},
                    {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
    		            {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"},
        		        {"name"=>4, "suit"=>"Club", "value"=>4, "string"=>"4 of Clubs"},
        	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
        		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
    best_hand(sample_hand,sample_board).should eq({:hand => :flush, :values => [13,12,10,7,4], :suit => "Clubs"})
  end
  it "should return straights" do
    sample_hand =  [{"name"=>9, "suit"=>"Diamond", "value"=>9, "string"=>"9 of Diamonds"},
                    {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
     		            {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
         		        {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
         	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
         		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
     best_hand(sample_hand,sample_board).should eq({:hand => :straight, :high => 13})
   end
   it "should return trips" do
    sample_hand =  [{"name"=>"King", "suit"=>"Spade", "value"=>13, "string"=>"King of Diamonds"},
                    {"name"=>"King", "suit"=>"Club", "value"=>13, "string"=>"King of Clubs"}]
    sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
      		          {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
    		            {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
        	          {"name"=>5, "suit"=>"Heart", "value"=>5, "string"=>"5 of Hearts"},
        		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
      best_hand(sample_hand,sample_board).should eq({:hand => :three_of_a_kind, :high => 13, :kickers => [12,11]})
    end  
    it "should return two pair" do
      sample_hand =  [{"name"=>2, "suit"=>"Spade", "value"=>2, "string"=>"2 of Diamonds"},
                      {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"}]
      sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
        		          {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
      		            {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
          	          {"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
          		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
        best_hand(sample_hand,sample_board).should eq({:hand => :two_pair, :high => 12, :second => 2, :kickers => [13]})
      end
    it "should return pairs" do
      sample_hand =  [{"name"=>3, "suit"=>"Spade", "value"=>3, "string"=>"3 of Diamonds"},
                      {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"}]
      sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
        		          {"name"=>"Queen", "suit"=>"Heart", "value"=>12, "string"=>"Queen of Hearts"},
      		            {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
          	          {"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
          		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
        best_hand(sample_hand,sample_board).should eq({:hand => :pair, :high => 12, :kickers => [13,11,10]})
    end        
    it "should return a high card" do
      sample_hand =  [{"name"=>3, "suit"=>"Spade", "value"=>3, "string"=>"3 of Diamonds"},
                      {"name"=>"Queen", "suit"=>"Club", "value"=>12, "string"=>"Queen of Clubs"}]
      sample_board = [{"name"=>"King", "suit"=>"Diamond", "value"=>13, "string"=>"King of Diamonds"},
        		          {"name"=>7, "suit"=>"Heart", "value"=>7, "string"=>"7 of Hearts"},
      		            {"name"=>"Jack", "suit"=>"Club", "value"=>11, "string"=>"Jack of Clubs"},
          	          {"name"=>2, "suit"=>"Heart", "value"=>2, "string"=>"2 of Hearts"},
          		        {"name"=>10, "suit"=>"Club", "value"=>10, "string"=>"10 of Clubs"}]
        best_hand(sample_hand,sample_board).should eq({:hand => :high_card, :kickers => [13,12,11,10,7]})
    end
end
