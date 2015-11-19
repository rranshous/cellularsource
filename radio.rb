require 'thread'
require 'httparty'
require 'uri'
require_relative 'http_interface'

class Radio

  def initialize user
    @user = user
    puts "radio has user: #{@user}"
    @http_interface = HttpInterface.new self
    setup_listeners
  end

  def send_assertion location, question, answer
    data = { question: question, answer: answer}
    url = URI.join location, '/assert'
    HTTParty.post url, body: data.to_json
  end

  def listen!
    puts "radio listening"
    @http_interface.run!
  end

  def news data
    question, answer = data['question'], data['answer']
    puts "radio got news: #{question} => #{answer}"
    @user.send :news, data['question'], data['answer']
  end

  def question data
    puts "radio got question: #{data['question']}"
    @user.send :question, data['question']
  end

  private

  def setup_listeners
    listen_for_news
    listen_for_inquiries
  end

  def listen_for_news
    puts "radio setting up listener for news"
    @http_interface.post :news, '/assert'
  end

  def listen_for_inquiries
    puts "radio setting up listener for questions"
    @http_interface.post :question, '/question'
  end
end
