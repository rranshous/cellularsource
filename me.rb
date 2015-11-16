class Me

  def initialize
    @location = nil
    @radio = Radio.new self
    @contact_deck = ContactDeck.new @radio
    @library = Library.new
    @medium = Medium.new
  end

  def figure_out_where_i_am
    @radio.listen_for_location()
  end

  def listen_and_learn
    @radio.listen_for_news
  end

  def news question, answer
    @library.note question, answer
    @contact_deck.send_assertion question, answer
  end

  def wait_vigilantly_for_inquiries
    @radio.listen_for_inquiries()
  end

  def question question
    answer = @library.lookup question
    if answer != :UNKNOWN
      @contact_deck.send_assertion @radio, question, answer
    end
  end

  def start_another_me
    @contact_deck.add @medium.clone_me
  end
end
