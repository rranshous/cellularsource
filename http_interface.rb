require 'sinatra/base'

class HttpInterface
  def initialize receiver
    @app = App
    host, port = ENV['HOST'] || '0.0.0.0', ENV['PORT']
    puts "http interface setting up app"
    @app.set :receiver, receiver
    @app.set :bind, host
    @app.set :port, port
  end

  def post msg, route
    puts "http interface setting up route #{route} notifying to #{msg}"
    @app.post(route) do
      settings.receiver.send msg, json_data
    end
  end

  def run!
    puts "running http interface"
    @app.run!
    puts "done running http interface"
  end

  private

  class App < Sinatra::Base
    helpers do
      def json_data
        request.body.rewind
        body = request.body
        if body.nil? || body == ""
          data = {}
        else
          data = JSON.load(body)
        end
        puts "json data: #{data}"
        return data
      end
    end
  end
end
