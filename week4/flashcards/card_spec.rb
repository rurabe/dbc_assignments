require 'simplecov'
SimpleCov.start
require 'rspec'
require './card.rb'

describe "a card" do
  before(:each) do
    @card = FC::Card.new("pineapple","pokey fruit")
  end

  it "should have a word" do
    @card.word.should == "pineapple"
  end

  it "should have a definition" do
    @card.definition.should == "pokey fruit"
  end

  it "should have a hint" do
    @card.hint.should == "p"
  end
end
