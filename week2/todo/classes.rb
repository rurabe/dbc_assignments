require 'time'
require 'colorize'

module Todo
  class Task
    attr_accessor :id, :text, :created_timestamp, :completed_timestamp, :tags
  
    def initialize(text)
      @id = $id_counter
      $id_counter += 1
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
      
    def set_priority
      
      
    end
      
  end

  class List
    attr_accessor :tasks
    def initialize
      $id_counter = 1
      @tasks = []
      self.read
    end
  
    def read
      read_array = File.open(File.expand_path("../data.txt",__FILE__),"r").readlines
      begin
        read_array.each_with_index do |line,index|
            cleaned_line = line.chomp.split("\t")
            self.add(cleaned_line[1])
            self.tasks[index].id = cleaned_line[0].to_i
            self.tasks[index].created_timestamp = Time.parse(cleaned_line[2])
            self.tasks[index].completed_timestamp = cleaned_line[3] == "incomplete" ? "incomplete" : Time.parse(cleaned_line[3])
            cleaned_line[4][1..-2].gsub(/[ #"\\]/,"").split(',').each {|tag| self.tasks[index].tag(tag) }
        end
        $id_counter = @tasks.max_by(&:id).id.to_i + 1
      rescue NoMethodError
      end

    end
  
    def write
      @tasks.sort_by!(&:id)
      File.open(File.expand_path("../data.txt",__FILE__),"w+") do |file|
        @tasks.each_with_index do |task,index|
          file << "#{task.id}\t#{task.text}\t#{task.created_timestamp}\t#{task.completed_timestamp}\t#{task.tags}\n"
        end
      end
    end

    def add(text)
      @tasks << Todo::Task.new(text)
    end    
    
    def display_tasks(tasks = @tasks.sort_by!(&:id))
      
      puts "TaskID\t#{"Description".ljust(35," ")}\tCreated At\tCompleted At\tTags\n"
      tasks.each do |task|
        percentile = task.id.to_f/@tasks.size.to_f
        text = task.text.ljust(35," ")
        created = task.created_timestamp.strftime(%Q(%b %d,%l:%M %p))
        completed = task.completed_timestamp == "incomplete" ? "incomplete" : task.completed_timestamp.strftime(%Q(%b %d,%l:%M %p))
        if percentile > 0.67
          color = :green
        elsif percentile < 0.34
          color = :red
        else
          color = :yellow
        end
        puts "#{task.id}\t#{text}\t#{created}\t#{completed}\t#{task.tags}".colorize(color)
      end
    end
    
    def reorder
      self.display_tasks
      puts "which task id do you want to move?"
      id_to_move = ( STDIN.gets.chomp.to_i )
      reordered_task = @tasks.find {|task| task.id == id_to_move }
      puts "what task id do you want it to be?"
      new_id = ( STDIN.gets.chomp.to_i).to_i
      @tasks.insert(new_id - 1,reordered_task)
      self.re_id
      self.display_tasks
    end
    
    def re_id
      @tasks.each_with_index do |task,index|
        task.id = index + 1
      end
    end
    
    
    def mark_complete
      self.display_tasks
      puts "which task id did you complete?"
      id_to_complete = ( STDIN.gets.chomp.to_i - 1 )
      @tasks[id_to_complete].complete
    end
    
    def delete
      self.display_tasks
      puts "which task id do you want to delete?"
      id_to_delete = ( STDIN.gets.chomp.to_i)
      @tasks.delete_if {|x| x.id == id_to_delete }
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
      puts "which task id do you want to tag?"
      id_to_tag = ( STDIN.gets.chomp.to_i - 1 )
      @tasks[id_to_tag].tag(tag)
      self.display_tasks
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