require_relative 'radio'
require_relative 'contact_deck'
require_relative 'library'
require_relative 'medium'

class Me

  def initialize
    @radio = Radio.new self
    @contact_deck = ContactDeck.new @radio
    @library = Library.new
    @medium = Medium.new
  end

  def exist!
    start_another_me
    @radio.listen!
  end

  def news question, answer
    @library.note question, answer
    @contact_deck.send_assertion question, answer
  end

  def question question
    answer = @library.lookup question
    if answer != :UNKNOWN
      @contact_deck.send_assertion @radio, question, answer
    end
  end

  private

  def start_another_me
    clone_location = @medium.clone_me
    raise "could not start clone" if clone_location == false
    @contact_deck.add clone_location
  end
end
