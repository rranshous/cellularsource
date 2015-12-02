require 'cloner'
require 'remembererer'

class Me
  class Survivor

    def initialize radio
      @radio = radio
      @cloner = Cloner.new @contact_deck
    end

    def exist
      puts "survivor existing"
      @radio.listen_for :news, self
      remember_to_spawn_clone
    end

    def news question, answer
      puts "survivor got news"
      # TODO: stuff
    end

    def remember_to_spawn_clone
      puts "survivor setting reminder to spawn"
      Remembererer.remind_me 30, @cloner, :start_clone
    end
  end
end
