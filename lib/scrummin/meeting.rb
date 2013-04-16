require "forwardable"

module Scrummin
  class Meeting
    attr_reader :participants

    def initialize(participants: [])
      @participants = participants.shuffle
    end

    extend Forwardable
    def_delegators :participants, :<<, :delete, :delete_at
    def_delegator :participants, :shift, :next

    def active?
      participants.any?
    end

    def over?
      participants.empty?
    end
  end
end
