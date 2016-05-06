require 'library'

class Me
  class Learner

    def initialize radio, contact_deck
      @radio = radio
      @contact_deck = contact_deck
      @library = Library.new
    end

    def exist
      @radio.listen_for :news, self
      @radio.listen_for :questions, self
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

  end
end
