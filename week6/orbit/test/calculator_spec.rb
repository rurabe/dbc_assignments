require 'rspec'
require './calculator.rb'

describe AdvancedCalculator::Calculator do
  
  before(:each) do
    @calculator = AdvancedCalculator::Calculator.new
  end
  
  describe "#evaluate" do
    it "solves postfix notations" do
      @calculator.evaluate("4 5 *").should == 20
      @calculator.evaluate("5 10 * 2 +").should == 52
      @calculator.evaluate("2 1 8 2 + 5 * + *").should == 102
      @calculator.evaluate("2 1 8 2 / + 5  + *").should == 20
    end
    
    it "solves prefix notations" do
      @calculator.evaluate('* 4 5').should == 20
      @calculator.evaluate("+ 2 * 5 10").should == 52
    end
    
    it "has the alias #evaluate_prefix" do
      @calculator.evaluate_prefix("+ 2 * 5 10").should == 52
    end
  
    it "has the alias #evaluate_postfix" do
      @calculator.evaluate_prefix("2 1 8 2 + 5 * + *").should == 102
    end
  end
    
  describe "#to_postfix" do
    it "translates prefix notations into postfix notations" do
      @calculator.to_postfix("+ 2 * 5 10").should == "5 10 * 2 +"
    end
  end
  
  describe "#to_prefix" do
    it "translates postfix notations into prefix notations" do
      @calculator.to_prefix('2 8 10 + *').should == '* 2 + 8 10'
    end
  end
    
  
end