module Scrummin
  class Person
    attr_reader :name
    attr_accessor :started_at, :ended_at

    def initialize(name)
      if name.nil? || name.strip == ""
        raise ArgumentError.new("name is required")
      end

      @name = name
    end

    def duration
      if started_at && ended_at
        ended_at - started_at
      end
    end

    def deviation(standard)
      (self.duration - standard).abs
    end

  end
end
