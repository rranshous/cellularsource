require 'cloner'
require 'remembererer'
require 'thread'

class Me
  class Survivor
    include MethodLocker

    def initialize radio, contact_deck
      @radio = radio
      @lock = Mutex.new
      @contact_deck = contact_deck
      @cloner = Cloner.new @contact_deck
      @parent_contacts = []
      @clone_started = false
    end

    def exist
      puts "survivor existing"
      @radio.listen_for :heartbeat, self
      set_check_on_parent_reminder
      set_send_heartbeat_reminder
    end

    def send_heartbeat
      puts "survivor sending heartbeat"
      @contact_deck.send_heartbeat
      set_send_heartbeat_reminder
    end

    def heartbeat source
      puts "survivor got heartbeat from #{source}"
      self.class.identify_as_parent(source) and note_parent_contact
    end

    def check_on_parent
      puts "survivor checking on parent"
      truncate_parent_contacts
      check_clone_started and return
      check_for_parent_contact and set_check_on_parent_reminder and return
      start_clone or set_check_on_parent_reminder
    end

    private

    def set_send_heartbeat_reminder time=5
      Remembererer.remind_me(time, self, :send_heartbeat)
    end

    def set_check_on_parent_reminder time=30
      Remembererer.remind_me(time, self, :check_on_parent)
    end

    def start_clone
      puts "survivor starting clone"
      @clone_started = @cloner.start_clone or return
      puts "survivor started clone"
    end

    def check_clone_started
      @clone_started
    end

    def check_for_parent_contact
      @parent_contacts.any?
    end

    def note_parent_contact
      with_lock { @parent_contacts << Time.now.to_i }
      true
    end

    def truncate_parent_contacts
      with_lock do
        too_long = Time.now.to_i - 60
        @parent_contacts = @parent_contacts.delete_if { t < too_long }
      end
    end

    def self.identify_as_parent source
      source.include? 'parent'
    end
  end
end
