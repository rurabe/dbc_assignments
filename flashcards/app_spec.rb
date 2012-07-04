require 'simplecov'
SimpleCov.start
require 'rspec'
require './app.rb'

describe "the flashcard app" do
  before(:each) do
    @app = FC::App.new
  end

  it "should have an array named cards" do
    @app.cards.should_not be nil
  end

  it "should read the file" do
    @app.read_file.include?("alias\tTo create a second name for the variable or method.\n").should be true
  end

  it "should parse the file" do
    @app.parse_file.include?(["alias","To create a second name for the variable or method."]).should be true
  end

  it "should create the cards" do
    @app.create_cards
    first_card = @app.cards.sort_by(&:word)[0]
    first_card.word.should == "alias"
    first_card.definition.should == "To create a second name for the variable or method."
  end

  it "should import, parse, and create the cards upon instantiation" do
    second_card = @app.cards.sort_by(&:word)[1]
    second_card.word.should == "and"
    second_card.definition.should == "A command that appends two or more objects together."
  end

  # it "should start a new round with a random card" do
  #   @app.start
  #   @app.rounds[0].should be_an_instance_of FC::Round
  # end

end
