require_relative 'radio'
require_relative 'contact_deck'
require_relative 'library'
require_relative 'cloner'
require_relative 'remembererer'

class Me

  def initialize
    @radio = Radio.new self
    @contact_deck = ContactDeck.new @radio
    @library = Library.new
    @cloner = Cloner.new @contact_deck
  end

  def exist!
    remind_self_to_spawn_clone
    @radio.listen!
  end

  def news question, answer
    puts "i've just heard some news: #{question} => #{answer}"
    @library.note question, answer
    puts "i'm telling everybody"
    @contact_deck.send_assertion question, answer
    {}.to_json
  end

  def question question
    puts "i received a question: #{question}"
    answer = @library.lookup question
    { question: question, answer: answer }.to_json
  end

  def remind_self_to_spawn_clone
    puts "me setting reminder to spawn"
    Remembererer.remind_me 10, @cloner, :start_clone
  end
end
