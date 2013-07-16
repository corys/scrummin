require "forwardable"

module Scrummin
  class Meeting
    attr_reader :participants, :position

    def initialize(participants: [], track_group_chat: false)
      @track_group_chat = track_group_chat
      @participants = participants.shuffle
      @participants << Person.new("group") if track_group_chat?
    end

    extend Forwardable
    def_delegators :participants, :delete, :delete_at

    def add_participant(participant)
      if track_group_chat?
        participants.insert(-2, participant)
      else
        participants << participant
      end
    end

    alias_method :<<, :add_participant

    def active?
      position && position < participants.size
    end

    def over?
      !active?
    end

    def current
      participants[position]
    end

    def next
      start unless active?
      current.ended_at = Time.now if current
      @position += 1
      current.started_at = Time.now if current
      current
    end

    def start
      @position = -1
      @participants.shuffle
    end

    private

    def track_group_chat?
      !!@track_group_chat
    end
  end
end
