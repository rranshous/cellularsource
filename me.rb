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
    if ENV['SPAWN'] == 'true'
      Thread.new do
        puts "sleeping before clone: 30s"
        sleep(30)
        puts "done sleeping, staring clone"
        start_another_me
      end
    end
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
    if answer != :UNKNOWN
      puts "i found the answer: #{answer}"
    else
      puts "i don't know the answer"
    end
    { question: question, answer: answer }.to_json
  end

  private

  def start_another_me
    clone_location = @medium.clone_me
    raise "could not start clone" if clone_location == false
    @contact_deck.add clone_location
  end
end
