require 'rspec'

def lister(array)
  new_array = []
  array.each_with_index do |f,i|
    new_array << "#{i+1}. #{f}"
  end
  new_array
end
    
    
describe "lister function" do
  it "should return the right list" do
    a = %w(bread milk eggs)
    lister(a).should eq(["1. bread","2. milk","3. eggs"])
  end
end