require 'time'

module Todo
  class Task
    attr_accessor :text, :created_timestamp, :completed_timestamp, :tags
  
    def initialize(text)
      @text = text
      @created_timestamp = Time.now
      @completed_timestamp = "incomplete"
      @tags = []
    end
    
    def complete
      @completed_timestamp = Time.now
    end
    
    def tag(tag)
      @tags << "\##{tag}"
    end
      
  end

  class List
    attr_accessor :tasks
    def initialize
      @tasks = []
      self.read
    end
  
    def read
      read_array = File.open(File.expand_path("../data.txt",__FILE__),"r").readlines
      read_array.each_with_index do |line,index|
        cleaned_line = line.chomp.split("\t")
        self.add(cleaned_line[1])
        self.tasks[index].created_timestamp = Time.parse(cleaned_line[2])
        self.tasks[index].completed_timestamp = cleaned_line[3] == "incomplete" ? "incomplete" : Time.parse(cleaned_line[3])
        cleaned_line[4][1..-2].gsub(/[ #"\\]/,"").split(',').each {|tag| self.tasks[index].tag(tag) }
      end
    end
  
    def write
      File.open(File.expand_path("../data.txt",__FILE__),"w+") do |file|
        @tasks.each_with_index do |task,index|
          file << "#{index+1}\t#{task.text}\t#{task.created_timestamp}\t#{task.completed_timestamp}\t#{task.tags}\n"
        end
      end
    end

    def add(text)
      @tasks << Todo::Task.new(text)
    end    
    
    def display_tasks(tasks = @tasks)
      puts "TaskID\t#{"Description".ljust(35," ")}\tCreated At\tCompleted At\tTags"
      tasks.each_with_index do |task,index|
        text = task.text.ljust(35," ")
        created = task.created_timestamp.strftime(%Q(%b %d,%l:%M %p))
        completed = task.completed_timestamp == "incomplete" ? "incomplete" : task.completed_timestamp.strftime(%Q(%b %d,%l:%M %p))
        puts "#{index+1}\t#{text}\t#{created}\t#{completed}\t#{task.tags}\n"
      end
    end
    
    def reorder
      self.display_tasks
      puts "which task do you want to move?"
      id_to_move = ( STDIN.gets.chomp.to_i - 1 )
      reordered_task = @tasks[id_to_move]
      @tasks.delete_at(id_to_move)
      puts "what task do you want it to be?"
      new_id = ( STDIN.gets.chomp.to_i - 1 )
      @tasks.insert(new_id,reordered_task)
      self.display_tasks
    end
    
    def mark_complete
      self.display_tasks
      puts "which task did you complete?"
      id_to_complete = ( STDIN.gets.chomp.to_i - 1 )
      @tasks[id_to_complete].complete
    end
    
    def delete
      self.display_tasks
      puts "which task did you delete?"
      id_to_delete = ( STDIN.gets.chomp.to_i - 1 )
      @tasks.delete_at(id_to_delete)
      return "bang. it's dead."
    end
    
    def display_by_creation_date
      new_array = @tasks.sort_by(&:created_timestamp)
      display_tasks(new_array)
      return "you've got shit to do"
    end
    
    def display_by_completion_date
      new_array = @tasks.select {|t| t.completed_timestamp != nil }.sort_by(&:completed_timestamp)
      display_tasks(new_array)
      return "you got shit done!"
    end
    
    def tag_task(tag,*id)
      self.display_tasks
      puts "which task do you want to tag?"
      id_to_tag = ( STDIN.gets.chomp.to_i - 1 )
      @tasks[id_to_tag].tag(tag)
    end

    def search_by_tags(tags_string)
      tags = tags_string.split.map {|tag| "\##{tag}"}
      new_array = @tasks.select {|t| !(t.tags & tags).empty?}.sort {|t| (t.tags & tags).size }
      display_tasks(new_array)
    end
    
    def search_by_priority(priority)
      new_array = [@tasks[priority.to_i]]
      display_tasks(new_array)
    end
    
    
  end
end