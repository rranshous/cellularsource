require 'httparty'
require 'uri'
require_relative 'cycle_source'

class Medium

  def initialize
    @cycle_client = CycleSource::Client.new
  end

  def spawn image
    puts "medium spawning #{image}"
    new_spawn_id = start_new_spawn image
    return new_spawn_url new_spawn_id
  end

  private

  def start_new_spawn image
    puts "medium starting new_spawn"
    new_spawn_id = @cycle_client.start image
    return false if new_spawn_id == false
    puts "medium started: #{new_spawn_id}"
    return new_spawn_id
  end

  def new_spawn_url new_spawn_id
    details = @cycle_client.status new_spawn_id
    ip = details['private_ip']
    port = ENV['PORT']
    url = "http://#{ip}:#{port}"
    puts "medium new_spawn url: #{url}"
    return url
  end
end
