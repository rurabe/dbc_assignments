class Item
  attr_reader :top_bidder, :current_bid

  def initialize(item_name,initial_bid)
    @current_bid = initial_bid
    @name = item_name
  end

  def bid(bidder_name,bid_offer)
    if @current_bid >= bid_offer
      "I'm sorry, but your bid of $#{bid_offer} is too low. The current bid is $#{@current_bid}"
    else
      @current_bid = bid_offer
      @top_bidder = bidder_name
    end
  end

  def current_buyout
    @current_bid * 2
  end

  def status
    "#{@top_bidder} is in the lead with a $#{@current_bid} bid."
  end
end