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
    first_card.word.should == "BEGIN"
    first_card.definition.should == "Designates code that must be run unconditionally at the beginning of the program before any other."
  end

  it "should import, parse, and create the cards upon instantiation" do
    second_card = @app.cards.sort_by(&:word)[1]
    second_card.word.should == "END"
    second_card.definition.should == "Designates, via code block, code to be executed just prior to program termination."
  end

  it "should welcome me to the app" do
    @app.should_receive(:puts).with("\n\n\nWelcome to the FlashCard App!\n\n\n")
    @app = FC::App.new
  end
end
