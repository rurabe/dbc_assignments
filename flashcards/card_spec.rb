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

describe "The player" do
  before(:each) do
    @the_player = Flashcards::Player.new('./words.txt')
    @the_player.stub!(:gets).and_return("q")
  end

  it "should be an instance of Player" do
    @the_player.should be_an_instance_of Flashcards::Player
  end

  it "should have an container for card objects" do
    @the_player.cards.methods.include?(:flatten).should be true
  end

  it "should import data from a file" do
    @the_player.import.include?(IO.readlines('./words.txt')[rand(0..2)]).should be true
  end

  it "should create card objects from the imported data" do
    @the_player.cards[rand(0..2)].should be_an_instance_of Flashcards::Card
  end

  it "should have cards with the terms and definition from the given file" do
    Hash[@the_player.parse_cards].keys.include?(@the_player.cards[rand(0..2)].term).should be true
    Hash[@the_player.parse_cards].values.include?(@the_player.cards[rand(0..2)].definition).should be true
  end

  it "should import all the words and definitions in the given file" do
    @the_player.cards.length.should == IO.readlines('./words.txt').length
  end

  it "should display a word on startup" do
    STDOUT.should_receive(:puts).at_least(:once)
    @the_player = Flashcards::Player.new('./words.txt')
    @the_player.stub!(:gets).and_return("who knows","q")
    @the_player.play
  end



end
