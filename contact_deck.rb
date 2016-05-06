require 'thread'
require_relative 'method_locker'

class ContactDeck
  include MethodLocker

  def initialize radio
    @radio = radio
    puts "deck using radio: #{radio}"
    @contacts = []
    @lock = Mutex.new
  end

  def send_assertion question, answer
    puts "deck sending assertion: #{question} => #{answer}"
    with_lock do
      @contacts.each do |location|
        puts "deck sending to: #{location}"
        @radio.send_assertion location, question, answer
        puts "deck done sending to: #{location}"
      end
    end
  end

  def send_heartbeat
    puts "deck sending heartbeat"
    with_lock do
      @contacts.each do |location|
        puts "deck sending to: #{location}"
        @radio.send_heartbeat 'parent'
        puts "deck done sending to: #{location}"
      end
    end
  end

  def add location
    puts "deck adding #{location}"
    with_lock { @contacts << location }
  end
end
