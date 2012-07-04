require 'simplecov'
SimpleCov.start
require 'rspec'
require './card.rb'
require './player.rb'

describe "A card" do
  before(:each) do
    @new_card = Flashcards::Card.new("tree", "outdoor plant")
    @new_card2 = Flashcards::Card.new("kitten", "small cat")
  end

  it "should be an instance of card" do
    @new_card.should be_an_instance_of Flashcards::Card
  end

  it "should store a term and definition and give them to me on request" do
    @new_card.term.should == "tree"
    @new_card.definition.should == "outdoor plant"
    @new_card2.term.should == "kitten"
    @new_card2.definition.should == "small cat"
  end

  it "should give me a hint on request" do
    @new_card.hint.should == "t"
    @new_card2.hint.should == "k"
  end
end
