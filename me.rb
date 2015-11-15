class Me

  def initialize
    @location = nil
    @radio = Radio.new
    @contact_deck = ContactDeck.new @radio
    @library = Library.new
    @medium = Medium.new
  end

  def figure_out_where_i_am
    @radio.listen_for_location()
  end

  def listen_and_learn
    @radio.listen_for_news do |assertion|
      question, answer = assertion[:question], assertion[:answer]
      @library.note question, answer
      @contact_deck.send_assertion question, answer
    end
  end

  def wait_vigilantly_for_inquiries
    @radio.listen_for_inquiries do |question|
      @contact_deck.send_assertion @radio, question, @library.lookup(question)
    end
  end

  def start_another_me
    @contact_deck.add @medium.clone_me
  end
end
