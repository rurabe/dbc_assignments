

  class Task
    attr_accessor :text
  
    def initialize(text)
      @text = text
    end
  end

  class List
    attr_accessor :tasks
    def initialize
      @tasks = []
      self.read
    end
  
    def add(text)
      @tasks << Task.new(text)
    end
  
    def read
      read_array = File.open(File.expand_path("../data.txt",__FILE__),"r").readlines
      read_array.each do |line|
        cleaned_line = line.chomp.split("\t")
        task = Task.new(cleaned_line[1])
        puts task.text
      end
    end
  
    def write
      File.open(File.expand_path("../data.txt",__FILE__),"w+") do |file|
        @tasks.each_with_index do |task,index|
          file << "#{index+1}\t#{task.text}\n"
        end
      end
    end
  
  end
