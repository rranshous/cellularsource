require 'thread'
require 'httparty'
require 'uri'
require_relative 'http_interface'

class Radio

  def initialize
    puts "radio has user: #{@user}"
    @http_interface = HttpInterface.new self
    @listeners = Hash.new([])
  end

  def listen_for type, listener_obj
    puts "radio adding listener [#{type}] #{listener_obj}"
    @listeners[type] << listener_obj
  end

  def send_assertion location, question, answer
    data = { question: question, answer: answer}
    url = URI.join location, '/assert'
    puts "radio HTTP POST to #{url}"
    HTTParty.post url, body: data.to_json
  end

  def start!
    puts "radio listening"
    setup_http_endpoints
    @http_interface.run!
  end

  def news data
    question, answer = data['question'], data['answer']
    puts "radio got news: #{question} => #{answer}"
    @listeners[:news].each do |listener_obj|
      puts "radio sending news to #{listener_obj}"
      listener_obj.send :news, data['question'], data['answer']
    end
  end

  def question data
    puts "radio got question: #{data['question']}"
    @listeners[:question].each do |listener_obj|
      puts "radio sending question to #{listener_obj}"
      listener_obj.send :question, data['question']
    end
  end

  private

  def setup_http_endpoints
    puts "radio setting up listener for news"
    @http_interface.register_post :news, '/assert'
    puts "radio setting up listener for questions"
    @http_interface.register_post :question, '/question'
  end
end
