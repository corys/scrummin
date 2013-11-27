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

    it "can move to next participant" do
      meeting = Meeting.new(participants: [sally, bob])
      first = meeting.remaining[0]
      second = meeting.remaining[1]
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
  end
end
