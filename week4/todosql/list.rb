require './task.rb'
require 'sqlite3'

module Todos
  class List
    def initialize
      @tasks = []
      @db = SQLite3::Database.new('./todo_data.db')
    end

    def add(task_order,description)
      @db.execute("INSERT INTO tasks (task_order, description, created_at) VALUES (#{task_order.to_i-0.1},'#{description}', '#{Time.now}');")
      renumber_task_order
    end

    def delete(task_order)
      @db.execute("DELETE FROM 'tasks' WHERE task_order=#{task_order};")
      renumber_task_order
    end

    def complete!(task_order)
      @db.execute("UPDATE tasks SET completed_at='#{Time.now}' WHERE task_order='#{task_order}';")
    end
    
    def reorder(old_task_order,new_task_order)
      if old_task_order > new_task_order
        @db.execute("UPDATE tasks SET task_order='#{new_task_order.to_i-0.1}' WHERE task_order='#{old_task_order}';")
      else 
        @db.execute("UPDATE tasks SET task_order='#{new_task_order.to_i+0.1}' WHERE task_order='#{old_task_order}';")
      end
      renumber_task_order
    end

    def display_list(selection=:all_tasks)
      import_task_objects(selection)
      @tasks.each do |task|
        task.display
      end
    end

    private
    
    def renumber_task_order
      all_tasks.each_with_index do |row,index|
        @db.execute("UPDATE tasks SET task_order='#{index+1}' WHERE id='#{row[0]}';")
      end
    end

    def import_task_objects(selection)
      @tasks = []
      self.send(selection).each do |row|
        @tasks << Task.new(row[1],row[2],row[3],row[4])
      end
    end

    def all_tasks
      @db.execute("SELECT * FROM tasks ORDER BY task_order ASC")
    end

    def incomplete
      @db.execute("SELECT * FROM tasks WHERE completed_at IS NULL ORDER BY created_at ASC")
    end

    def complete
      @db.execute("SELECT * FROM tasks WHERE completed_at IS NOT NULL ORDER BY completed_at DESC")
    end
  end
end
