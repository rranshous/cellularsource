class App < Sinatra::Base
  helpers do
    def json_data
      request.body.rewind
      body = request.body
      if body.nil? || body == ""
        return {}
      else
        return JSON.load(body)
      end
    end
  end
end

class HttpInterface
  def initialize receiver
    @app = App
    @app.set :receiver, receiver
  end

  def post msg, route, &blk
    @app.post(route) do
      settings.receiver.send msg, json_data
    end
  end

  def run!
    @app.run!
  end
end
