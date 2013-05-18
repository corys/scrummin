require "forwardable"

module Scrummin
  class Meeting
    attr_reader :participants, :position, :winners, :winning_target, :total_duration

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
      participants.map(&:duration).inject(:+)    
    end
    
    def get_winner
        deviation_array = Array.new(participants.length)
        @winners = Array.new()       

        if deviation_array.length > 0
          deviation_array = participants.sort_by { |participant| participant.deviation(@winning_target) }

          place = 0
          prev_deviation = -1
          deviation_array.each do |participant|
            if prev_deviation != participant.deviation(@winning_target)
              prev_deviation = participant.deviation(@winning_target)
              place += 1
            end

            @winners << {:place => place, :participant => participant}
          end

        end      
    end

  end
end
