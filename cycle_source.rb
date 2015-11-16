require 'json'
require 'uri'
require 'httparty'

class CycleSource
  class Client
    def start image
      puts "cycle start [#{base_url}]: #{image}"
      data = { image: image }
      url = URI.join base_url, '/start'
      r = HTTParty.post(url, body: data.to_json)
      return false if r['running'] == false
      r.parsed_response['id']
    end

    def status container_id
      puts "cycle status: #{container_id}"
      url = URI.join base_url, '/status/', container_id
      status = HTTParty.get(url).parsed_response
      puts "cycle status [#{container_id}]: #{status}"
      return status
    end

    private

    def base_url
      url = ENV['CYCLESOURCE_URL']
      raise "missing CYCLESOURCE_URL" unless url
      puts "cycle base_url: #{url}"
      return url
    end
  end
end
