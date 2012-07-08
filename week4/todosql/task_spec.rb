require 'simplecov'
SimpleCov.start
require 'rspec'
require './task.rb'

describe 'A Task' do
  before(:each) do
    @new_task = Todos::Task.new(3, 'go to kuru kuru sushi')
  end
  describe 'should have a display method that' do
    
    it "should show the task order number" do
      @new_task.should_receive(:puts).with(/3\t/)
    end

    it 'should have the task description' do
      @new_task.should_receive(:puts).with(/go to kuru kuru sushi/)
    end

    it 'should stamp the Task with the time it was created' do
      run_time = Time.now
      @new_task.should_receive(:puts).with(/#{run_time}/)
    end

    it 'should stamp the Task with the time it was completed' do
      two_minutes_from_now = Time.at(Time.now+120)
      Time.stub!(:now).and_return(two_minutes_from_now)
      @new_task.complete
      @new_task.should_receive(:puts).with(/#{two_minutes_from_now}/)
    end
    
    it 'should show the tags the task has been tagged with' do
      @new_task.tag("da kine")
      @new_task.should_receive(:puts).with(/da kine/)
    end

    after(:each) do
      @new_task.display
    end
  end

  describe "should have a complete method" do
    it "should stamp the time it was completed" do
      @new_task.complete
      @new_task.complete?.should eq true
    end
  end

end