require 'sqlite3'

module Todos
  class Tag
    attr_reader :name
    def initialize(name)
      @db = SQLite3::Database.new('./todo_data.db')
      @db.execute("DELETE from tags;")
      @name = name
      store
    end
    
    private
    
    def store
      @db.execute("INSERT INTO tags (name) VALUES ('#{@name}')")
    end
  end
end