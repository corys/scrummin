require "spec_helper"
require "time"

module Scrummin
  describe Person do
    it "requires a name" do
      expect { Person.new(nil) }.to raise_error(ArgumentError)
      expect { Person.new("  \t\n  ") }.to raise_error(ArgumentError)
    end

    it "persists name" do
      Person.new("Bob").name.should == "Bob"
    end

    it "has a duration" do
      bob = Person.new("Bob")
      bob.started_at = Time.parse("1986-01-28 16:36:45 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:38:00 UTC")
      bob.duration.should == 75.0
    end
  end
end
