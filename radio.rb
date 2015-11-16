require 'thread'

class Radio

  def initialize user
    @user = user
    @my_location = nil
    @http_interface = HttpInterface.new self
    @lock = Mutex.new
  end

  def listen_for_location
    @http_interface.post self, :location, '/your_location'
  end

  def location data
    @lock.synchronize { @location = data['location'] }
  end

  def listen_for_news
    @http_interface.post self, :news, '/assert'
  end

  def news data
    @user.send :news, data['question'], data['answer']
  end

  def listen_for_inquiries
    @http_interface.get self, :question, '/question'
  end

  def question data
    @user.send :question, data['question']
  end
end
