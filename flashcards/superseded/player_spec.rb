require 'simplecov'
SimpleCov.start
require 'rspec'
require './card.rb'
require './player.rb'

describe "The player" do
  describe "generally" do
    before(:each) do
      @the_player = Flashcards::Player.new('./words.txt')

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

    it "should display a definition on start-up" do
      STDOUT.should_receive(:puts).with(/Definition/).at_least(:once)
      @the_player = Flashcards::Player.new('./words.txt')
      @the_player.play
    end

    it "should ask the user if they know the word"

    it "should tell me if the word is correct" do
      STDOUT.should_receive(:puts).with(/Definition/).at_least(:once)
      STDOUT.should_receive(:puts).with("Correct").at_least(:once)
      @the_player.stub!(:prompt).and_return("pineapple")
      @the_player = Flashcards::Player.new('./sample.txt')
      puts @the_player.prompt
      @the_player.play
    end




  end
end