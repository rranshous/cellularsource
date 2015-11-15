
class ContactDeck

  def initialize radio
    @radio = radio
    @contacts = []
  end

  def send_assertion question, answer
    @contacts.each do |location|
      @radio.send_assertion location, question, answer
    end
  end

  def add location
    @contacts << location
  end

end
