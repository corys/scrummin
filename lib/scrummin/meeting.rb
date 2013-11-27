require "forwardable"

module Scrummin
  class Meeting
    attr_reader :participants, :remaining, :current

    def initialize(participants: [], track_group_chat: false)
      @track_group_chat = track_group_chat
      @participants = participants
      @remaining = @participants.shuffle

      if track_group_chat?
        @participants << group
        @remaining << group
      end
    end

    def delete(participant)
      participants.delete(participant)
      remaining.delete(participant)
    end

    def add_participant(participant)
      remaining << participant

      if track_group_chat? && remaining.include?(group)
        remaining.delete(group)
        remaining.shuffle!
        remaining << group
      else
        remaining.shuffle!
      end

      if track_group_chat?
        participants.insert(-2, participant)
      else
        participants << participant
      end
    end

    alias_method :<<, :add_participant

    def active?
      remaining.any? || current
    end

    def over?
      !active?
    end

    def next
      @current.ended_at = Time.now if current
      @current = remaining.shift
      @current.started_at = Time.now if current
      @current
    end

    private

    def track_group_chat?
      !!@track_group_chat
    end

    def group
      @group ||= Person.new("group")
    end
  end
end
