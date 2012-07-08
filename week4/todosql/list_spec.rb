require 'simplecov'
SimpleCov.start
require 'rspec'
require './list.rb'
require './task.rb'

describe "A List" do
  before(:each) do
    @db = SQLite3::Database.new('./todo_data.db')
    @db.execute("DELETE from tasks;")
    @new_list = Todos::List.new
  end
  describe "has" do
    describe "an add method that" do
      it "should add tasks to the list" do
        @new_list.add(1,"cruise north shore")
        STDOUT.should_receive(:puts).with(/cruise north shore/).at_least(:once)
      end
    end

    describe "a delete method that" do
      it "deletes a task"do
        @new_list.add(1,"climb diamond head")
        STDOUT.should_receive(:puts).with(/climb diamond head/).at_least(:once)
        @new_list.display_list
        @new_list.delete(1)
        STDOUT.should_not_receive(:puts).with(/climb diamond head/)
      end
    end

    describe "a complete method that" do
      it "marks a task complete" do
        two_minutes_from_now = (Time.now+120)
        @new_list.add(1,"go first fridays")
        Time.stub!(:now).and_return(two_minutes_from_now)
        @new_list.complete!(1)
        STDOUT.should_receive(:puts).with(/1\tgo first fridays.*#{two_minutes_from_now}/)
      end
    end
    
    describe "a reorder function that" do
      it "allows the user to reprioritize tasks" do
        @new_list.add(1,"eat ahi katsu")
        @new_list.add(2,"eat teds haupia chocolate pie")
        @new_list.add(2,"eat monchong with little bit shoyu")
        @new_list.reorder(2,1)
        STDOUT.should_receive(:puts).with(/1\teat monchong with little bit shoyu/)
        STDOUT.should_receive(:puts).with(/2\teat ahi katsu/)
        STDOUT.should_receive(:puts).with(/3\teat teds haupia chocolate pie/)
      end
      
      it "allows the user to reprioritize tasks downwards" do
        @new_list.add(1,"eat ahi katsu")
        @new_list.add(2,"eat teds haupia chocolate pie")
        @new_list.add(2,"eat monchong with little bit shoyu")
        @new_list.reorder(1,3)
        STDOUT.should_receive(:puts).with(/1\teat monchong with little bit shoyu/)
        STDOUT.should_receive(:puts).with(/2\teat teds haupia chocolate pie/)
        STDOUT.should_receive(:puts).with(/3\teat ahi katsu/)
      end
      
      it "reorders the list when something is added" do
        @new_list.add(1,"go to rainbows")
        @new_list.add(2,"go to taniokas")
        @new_list.add(2,"go to pioneer saloon")
        @new_list.add(1,"go to kennys")
        STDOUT.should_receive(:puts).with(/1\tgo to kennys/)
        STDOUT.should_receive(:puts).with(/2\tgo to rainbows/)
        STDOUT.should_receive(:puts).with(/3\tgo to pioneer saloon/)
        STDOUT.should_receive(:puts).with(/4\tgo to taniokas/)
      end
      
      it "reorders the list when something is deleted" do
        @new_list.add(1,"go shop ala moana")
        @new_list.add(2,"hang out at kahala mall")
        @new_list.add(2,"shop at liberty house")
        @new_list.delete(2)
        STDOUT.should_receive(:puts).with(/1\tgo shop ala moana/)
        STDOUT.should_receive(:puts).with(/2\thang out at kahala mall/)
      end
    end

    after(:each) do
      @new_list.display_list
    end
  end
  
  describe "will" do
    it "list incomplete tasks" do
      @new_list.add(1,"go climb the pillboxes at lanikai")
      @new_list.add(2,"go diving at point panics")
      @new_list.complete!(2)
      STDOUT.should_receive(:puts).with(/go climb the pillboxes at lanikai/)
      STDOUT.should_not_receive(:puts).with(/go diving at point panics/)
      @new_list.display_list(:incomplete)
    end
  
    it "list complete tasks" do
      @new_list.add(1,"go see the green")
      @new_list.add(2,"go see katchafire")
      @new_list.complete!(2)
      STDOUT.should_receive(:puts).with(/go see katchafire/)
      STDOUT.should_not_receive(:puts).with(/go see the green/)
      @new_list.display_list(:complete)
    end
  end
end