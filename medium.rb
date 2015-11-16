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
    return clone_url clone_id
  end

  private

  def start_clone
    puts "medium starting clone"
    clone_id = @cycle_client.start our_image
    return false if clone_id == false
    puts "medium started: #{clone_id}"
    return clone_id
  end

  def clone_url clone_id
    details = @cycle_client.status clone_id
    host = details['host']
    port = details['ports']['80']
    "http://#{host}:#{port}"
  end

  def our_image
    image = ENV['DOCKER_IMAGE']
    puts "medium image: #{image}"
    raise "no image provided: DOCKER_IMAGE required" unless image
    return image
  end
end
