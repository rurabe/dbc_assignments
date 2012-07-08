module Todos
  class Task
    def initialize(order, description, created_at=Time.now, completed_at=nil)
      @order = order.to_i
      @description = description
      @created_at = created_at
      @completed_at = completed_at
      @tags=[]
    end

    def display
      justified_description = @description.ljust(35," ")
      puts "#{@order}\t#{justified_description} #{@created_at}\t#{@completed_at}"
    end

    def complete
      @completed_at = Time.now
    end

    def complete?
      !@completed_at.nil?
    end
    
    def tag(tag_name)
      
    end
    
  end
end