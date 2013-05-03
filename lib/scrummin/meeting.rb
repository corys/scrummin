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

    def winner
      @winner
    end

    def winning_target
      @winning_target
    end

    def total_duration
      @total_duration
    end

    def calculate_stats
      @total_duration = get_total_duration
      @winning_target = @total_duration/participants.length    
      get_winner 
    end   


    private

    def track_group_chat?
      !!@track_group_chat
    end

    def get_total_duration
      total_duration = 0
      participants.each do |participant|
        total_duration += participant.duration
      end
      return total_duration
    end

    def get_winner
      if participants.length > 0
        min_duration =  (participants[0].duration - @winning_target).abs
        @winner = participants[0]

        participants.each do |participant|
          deviation = (participant.duration - @winning_target).abs
          if deviation < min_duration
              min_duration = deviation
              @winner = participant
          end
        end

      end
    end

  end
end
