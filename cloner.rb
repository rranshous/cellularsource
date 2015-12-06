require 'medium'
require 'env_context'

class Cloner

  def initialize contact_deck
    @medium = Medium.new
    @contact_deck = contact_deck
  end

  def start_clone
    puts "cloner starting clone"
    our_image && clone_location = @medium.spawn(our_image) or begin
      puts "cloner failed to spawn clone"
      return false
    end
    puts "clone started"
    @contact_deck.add clone_location
    return true
  end

  private

  def our_image
    EnvContext.with('DOCKER_IMAGE') do |docker_image|
      puts "medium image: #{docker_image}"
      return docker_image
    end
    return false
  end
end
