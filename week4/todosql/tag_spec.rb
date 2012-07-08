require 'simplecov'
SimpleCov.start
require 'rspec'
require 'sqlite3'
require './tag.rb'

describe "A tag" do
  before(:each) do
    @db = SQLite3::Database.new('./todo_data.db')
    @new_tag = Todos::Tag.new("da kine")
  end
  
  it "has a name, which is also its description" do
    @new_tag.name.should == "da kine"
  end
  
  it "stores itself in the database upon creation" do
    @db.execute("SELECT name FROM tags").flatten.include?("da kine").should be true
  end
  
  it "should only save one if you add the same tag" do
    @another_tag = Todos::Tag.new("da kine")
    @db.execute("SELECT name FROM tags").flatten.count("da kine").should == 1
  end
end
