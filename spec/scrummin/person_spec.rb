require "spec_helper"

module Scrummin
  describe Person do
    it "requires a name" do
      expect { Person.new(nil) }.to raise_error(ArgumentError)
      expect { Person.new("  \t\n  ") }.to raise_error(ArgumentError)
    end

    it "persists name" do
      Person.new("Bob").name.should == "Bob"
    end
  end
end
