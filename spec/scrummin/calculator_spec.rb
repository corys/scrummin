require "spec_helper"
require "time"

module Scrummin
  describe Calculator do
    let(:bob) { Person.new("bob") }
    let(:sally) { Person.new("sally") }
    let(:siona) { Person.new("siona") }

    it "tracks total meeting time" do
      meeting = Meeting.new(participants: [sally, bob])
      sally.started_at = Time.parse("1986-01-28 16:36:00 UTC")
      sally.ended_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.started_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:37:30 UTC")
      calculator = Calculator.new(meeting)
      calculator.total_duration.should == 90.0
    end

    it "calculates winning target" do
      meeting = Meeting.new(participants: [sally, bob])
      sally.started_at = Time.parse("1986-01-28 16:36:00 UTC")
      sally.ended_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.started_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:37:30 UTC")
      calculator = Calculator.new(meeting)
      calculator.winning_target.should ==  45.0
    end

    it "picks the winner" do
      meeting = Meeting.new(participants: [sally, bob, siona])
      sally.started_at = Time.parse("1986-01-28 16:36:00 UTC")
      sally.ended_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.started_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:42:00 UTC")
      siona.started_at = Time.parse("1986-01-28 16:38:00 UTC")
      siona.ended_at = Time.parse("1986-01-28 16:39:00 UTC")
      calculator = Calculator.new(meeting)

      #array.sort_by does not return the same result every time
      #calculator.winners[0][:participant].should == siona
      calculator.winners[0][:place].should == 1

      #calculator.winners[1][:participant].should == sally
      calculator.winners[1][:place].should == 1

      calculator.winners[2][:participant].should == bob
      calculator.winners[2][:place].should == 2
    end
  end
end
