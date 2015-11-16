require 'httparty'
require 'uri'
require_relative 'cycle_source'

class Medium

  def initialize
    @cycle_client = CycleSource::Client.new
  end

  def clone_me
    puts "medium cloning self"
    clone_id = start_clone
    clone_url = give_clone_its_location clone_id
    return clone_url
  end

  private

  def start_clone
    puts "medium starting clone"
    clone_id = @cycle_client.start our_image
    return false if clone_id == false
    puts "medium started: #{clone_id}"
    return clone_id
  end

  def give_clone_its_location clone_id
    details = @cycle_client.status clone_id
    host = details['host']
    port = details['ports']['80']
    clone_url = "http://#{host}:#{port}"
    puts "medium giving clone it's location: #{clone_id} => #{clone_url}"
    url = URI.join(clone_url, '/your_location').to_s
    puts "medium posting to: #{url} => #{clone_url}"
    HTTParty.post url, host: { location: clone_url }.to_json
    return clone_url
  end

  def our_image
    image = ENV['DOCKER_IMAGE']
    puts "medium image: #{image}"
    raise "no image provided: DOCKER_IMAGE required" unless image
    return image
  end
end
