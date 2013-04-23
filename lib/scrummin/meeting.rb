require "forwardable"

module Scrummin
  class Meeting
    attr_reader :participants, :position

    def initialize(participants: [], track_group_chat: false)
      @participants = participants.shuffle
      @participants << Person.new("group") if track_group_chat
    end

    extend Forwardable
    def_delegators :participants, :<<, :delete, :delete_at

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
  end
end
