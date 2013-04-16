module Scrummin
  class Person
    attr_reader :name

    def initialize(name)
      if name.nil? || name.strip == ""
        raise ArgumentError.new("name is required")
      end

      @name = name
    end
  end
end
