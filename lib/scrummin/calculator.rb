module Scrummin
  class Calculator
    attr_reader :meeting

    def initialize(meeting)
      @meeting = meeting
    end

    def total_duration
      participants.map(&:duration).inject(:+)
    end

    def participants
      meeting.participants
    end

    def winning_target
      total_duration / participants.length
    end

    def winners
      deviation_array = Array.new(participants.length)
      winners = Array.new()

      if deviation_array.length > 0
        deviation_array = participants.sort_by { |participant| participant.deviation(winning_target) }

        place = 0
        prev_deviation = -1
        deviation_array.each do |participant|
          if prev_deviation != participant.deviation(winning_target)
            prev_deviation = participant.deviation(winning_target)
            place += 1
          end

          winners << {:place => place, :participant => participant}
        end
      end
      winners
    end
  end
end
