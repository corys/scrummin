require "spec_helper"

module Scrummin
  describe Meeting do
    let(:bob) { stub }
    let(:sally) { stub }

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
      first = meeting.participants.first
      meeting.next.should == first
      meeting.participants.should_not include first
    end

    it "is active is participants remain" do
      meeting = Meeting.new(participants: [sally, bob])
      meeting.next
      meeting.should be_active
    end

    it "is over when no more participants" do
      meeting = Meeting.new(participants: [sally])
      meeting.next
      meeting.should be_over
    end
  end
end
