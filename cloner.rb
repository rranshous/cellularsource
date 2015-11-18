require_relative 'medium'
require_relative 'context'

class Cloner

  def initialize contact_deck
    @medium = Medium.new
    @contact_deck = contact_deck
  end

  def start_clone
    puts "cloner starting to clone"
    Context.with('SPAWN') do
      puts "cloner starting clone"
      clone_location = @medium.spawn our_image
      raise "could not start clone" if clone_location == false
      @contact_deck.add clone_location
      return
    end
    puts "cloner did not start clone"
  end

  private

  def our_image
    Context.with('DOCKER_IMAGE') do |docker_image|
      puts "medium image: #{docker_image}"
      return docker_image
    end
    raise "no image provided: DOCKER_IMAGE required"
  end
end
