require 'tinder'

module Scrummin
  class Notifier
    TOKEN = '2d968d9fd9146b10e8ee7f24a6dc40b24c69063e'

    def all(text)
      if text.include? "\n"
        room.paste text
      else
        room.speak text
      end
    rescue StandardError => e
      puts "ERROR: #{e.class}"
      puts e.backtrace
    end

    private

    def campfire
      @campfire ||= Tinder::Campfire.new 'resdat', token: TOKEN
    end

    def room
      @room ||= campfire.rooms.find { |r| r.name == "Scrummin" }
    end
  end
end
