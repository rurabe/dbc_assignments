require './detail.rb'

module AddressBook
  class Person
    attr_reader :name, :details 
    def initialize(name)
      @name = name
      @details = []
    end
    
    def store(type,body)
      @details << Detail.new(type,body)
    end
    
    def list(type)
      matches = @details.select {|detail| detail.type == type}
      matches.map {|detail| detail.body}
    end
  end
end