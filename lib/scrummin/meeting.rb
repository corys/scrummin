require "forwardable"

module Scrummin
  class Meeting
    attr_reader :participants, :position

    def initialize(participants: [])
      @participants = participants
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
      @position += 1
      current
    end

    def start
      @position = -1
      @participants.shuffle
    end
  end
end
