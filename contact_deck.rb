require 'thread'

class ContactDeck

  def initialize radio
    @radio = radio
    puts "deck using radio: #{radio}"
    @contacts = []
    @lock = Mutex.new
  end

  def send_assertion question, answer
    puts "deck sending assertion: #{question} => #{answer}"
    @contacts.each do |location|
      puts "deck sending to: #{location}"
      @radio.send_assertion location, question, answer
      puts "deck done sending to: #{location}"
    end
  end

  def add location
    puts "deck adding #{location}"
    @lock.synchronize { @contacts << location }
  end

end
