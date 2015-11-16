class ContactDeck

  def initialize radio
    @radio = radio
    puts "deck using radio: #{radio}"
    @contacts = []
  end

  def send_assertion question, answer
    puts "deck sending assertion: #{question} => #{answer}"
    @contacts.each do |location|
      puts "deck sending to: #{location}"
      @radio.send_assertion location, question, answer
    end
  end

  def add location
    puts "deck adding #{location}"
    @contacts << location
  end

end
