require 'cloner'
require 'remembererer'
require 'thread'

class Me
  class Survivor
    include MethodLocker

    def initialize radio
      @radio = radio
      @lock = Mutex.new
      @cloner = Cloner.new @contact_deck
      @parent_contacts = []
    end

    def exist
      puts "survivor existing"
      @radio.listen_for :heartbeat, self
      check_on_parent
    end

    def heartbeat source
      source['parent'] and begin # confusing syntax
        note_parent_contact
      end
    end

    def check_on_parent
      puts "survivor checking on parent"
      truncate_parent_contacts.first and begin
        Remembererer.remind_me 30, self, :check_on_parent
        return
      end
      puts "survivor starting child"
      @cloner.start_clone
    end

    private

    def note_parent_contact
      with_lock { @parent_contacts << Time.now.to_i }
    end

    def truncate_parent_contacts
      with_lock do
        too_long = Time.now.to_i - 60
        @parent_contacts = @parent_contacts.delete_if { t < too_long }
        return @parent_contacts.to_enum
      end
    end
  end
end
