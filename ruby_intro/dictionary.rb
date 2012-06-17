class Dictionary < Hash
    attr_accessor :entries
    
    def initialize
        @entries = {}
    end
    
    def add(new_words)
        if %({#{new_words}).include? "=>" 
          @entries.merge!(new_words)
        else
          @entries[new_words] = nil
        end
    end
    
    def keywords
        @entries.keys.sort
    end
    
    def include?(keyword)
      @entries.include?(keyword)
    end
    
    def find(keyword)
      matched_keys = {}
      
      @entries.each_key do |keys|
        keys.start_with?(keyword) == true ? matched_keys[keys] = @entries[keys] : nil
      end
      matched_keys
    end
end