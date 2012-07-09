module AddressBook
  class Detail
    attr_reader :type, :body
    def initialize(type,body)
      @type = type
      @body = body
    end
  end
end