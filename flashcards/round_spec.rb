require 'simplecov'
SimpleCov.start
require 'rspec'
require './round.rb'

describe "a round" do
  before(:each) do
    @a_card = double("Card")
    @a_card.stub!(:word => "pineapple", :definition => "pokey fruit")
    @round = FC::Round.new(@a_card)
  end

  it "should tell the user they are correct if they get it right" do
    @round.should_receive(:puts).with("pokey fruit").once
    @round.should_receive(:puts).with("Correct!")
    @round.stub!(:gets).and_return("pineapple")
    @round.play
  end

  it "should finish the round if the user gets it correct" do
    @round.should_receive(:puts).with("pokey fruit").once
    @round.should_receive(:puts).with("Correct!").at_most(:once)
    @round.stub!(:gets).and_return("pineapple")
    @round.play
  end

  it "should tell the user they are correct even if they get it wrong a few times" do
    @round.should_receive(:puts).with("pokey fruit").once
    @round.should_receive(:printf).with("Do you know what I'm talking about?:").exactly(3).times
    @round.should_receive(:puts).with("Nope, try again:").exactly(2).times
    @round.should_receive(:puts).with("Correct!").once
    @round.stub!(:gets).and_return("crabapple","apple","pineapple")
    @round.play
  end

  it "should give the user three chances, then tell them the answer" do
    @round.should_receive(:puts).with("pokey fruit").once
    @round.should_receive(:printf).with("Do you know what I'm talking about?:").exactly(3).times
    @round.should_receive(:puts).with("Nope, try again:").exactly(2).times
    @round.should_receive(:puts).with("Ah, it was pineapple").once
    @round.stub!(:gets).and_return("crabapple","apple","apple pie")
    @round.play
  end




end