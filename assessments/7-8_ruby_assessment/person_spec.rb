require 'simplecov'
SimpleCov.start
require 'rspec'
require './person.rb'
include AddressBook

describe Person do

  
  before(:each) do
    @new_guy = Person.new("Ned Stark")
  end 
  context "#initialize" do
    it "should store a person's name" do
      @new_guy.name.should == "Ned Stark"
    end
  end
  context "#store" do 
    it "should store the person's details" do
      #I tried to stub Detail, but it wasn't working and completing class Detail took two seconds
      @new_guy.store(:email,"lord@winterfell.com")
      @new_guy.list(:email).include?("lord@winterfell.com").should be true
    end
  end
  context "#list" do
    it "should return details about the person" do
      @new_guy.store(:address, "The Keep, Winterfell")
      @new_guy.store(:address, "The Hand's Quarters, King's Landing")
      @new_guy.list(:address).include?("The Keep, Winterfell").should be true
      @new_guy.list(:address).include?("The Hand's Quarters, King's Landing").should be true
    end
  end
end