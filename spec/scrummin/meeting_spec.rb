require "spec_helper"
require "time"

module Scrummin
  describe Meeting do
    let(:bob) { Person.new("bob") }
    let(:sally) { Person.new("sally") }
    let(:siona) { Person.new("siona") }

    it "can be created with participants" do
      people = [bob, sally]
      Meeting.new(participants: people).participants.should include bob
      Meeting.new(participants: people).participants.should include sally
    end

    it "can be created with no participants" do
      Meeting.new.participants.should be_empty
    end

    it "can add participants" do
      meeting = Meeting.new(participants: [bob])
      meeting << sally
      meeting.participants.should include bob
      meeting.participants.should include sally
    end

    it "inserts new participants before the group" do
      meeting = Meeting.new(participants: [bob], track_group_chat: true)
      meeting << sally
      meeting.participants.should include sally
      meeting.participants.last.should_not == sally
    end

    it "can delete participants" do
      meeting = Meeting.new(participants: [sally])
      meeting.delete sally
      meeting.participants.should_not include sally
    end

    it "can delete participants by index" do
      meeting = Meeting.new(participants: [sally, bob])
      index = meeting.participants.index(bob)
      meeting.delete_at(index)
      meeting.participants.should_not include bob
    end

    it "can move to next participant" do
      meeting = Meeting.new(participants: [sally, bob])
      first = meeting.participants[0]
      second = meeting.participants[1]
      meeting.next.should == first
      meeting.next.should == second
    end

    it "is active is participants remain" do
      meeting = Meeting.new(participants: [sally, bob])
      meeting.next
      meeting.should be_active
    end

    it "is over when no more participants" do
      meeting = Meeting.new(participants: [sally])
      meeting.next
      meeting.next
      meeting.should be_over
    end

    it "tracks participant time" do
      meeting = Meeting.new(participants: [sally])
      started = Time.parse("1986-01-28 16:36:45 UTC")
      ended = Time.parse("1986-01-28 16:38:00 UTC")
      Time.stub(now: started)
      meeting.next
      Time.stub(now: ended)
      meeting.next
      sally.started_at.should == started
      sally.ended_at.should == ended
    end

    it "can optional track the 'group'" do
      meeting = Meeting.new(participants: [sally], track_group_chat: true)
      meeting.participants.last.name.should == "group"
    end

    it "trakcs total meeting time" do
      meeting = Meeting.new(participants: [sally, bob])
      sally.started_at = Time.parse("1986-01-28 16:36:00 UTC")
      sally.ended_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.started_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:37:30 UTC")  
      meeting.calculate_stats
      meeting.total_duration.should ==  90.0
    end

    it "calculates winning target" do
      meeting = Meeting.new(participants: [sally, bob])
      sally.started_at = Time.parse("1986-01-28 16:36:00 UTC")
      sally.ended_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.started_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:37:30 UTC")  
      meeting.calculate_stats
      meeting.winning_target.should ==  45.0
    end

    it "picks the winner" do
      meeting = Meeting.new(participants: [sally, bob, siona])
      sally.started_at = Time.parse("1986-01-28 16:36:00 UTC")
      sally.ended_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.started_at = Time.parse("1986-01-28 16:37:00 UTC")
      bob.ended_at = Time.parse("1986-01-28 16:42:00 UTC")
      siona.started_at = Time.parse("1986-01-28 16:38:00 UTC")
      siona.ended_at = Time.parse("1986-01-28 16:39:00 UTC")
      meeting.calculate_stats

      #array.sort_by does not return the same result every time
      #meeting.winners[0][:participant].should == siona
      meeting.winners[0][:place].should == 1

      #meeting.winners[1][:participant].should == sally
      meeting.winners[1][:place].should == 1

      meeting.winners[2][:participant].should == bob
      meeting.winners[2][:place].should == 2      
    end

  end
end
