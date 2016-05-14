$:.unshift File.dirname(__FILE__)

require 'radio'
require 'contact_deck'
require 'me/learner'
require 'me/survivor'

class Me

  def initialize
    @radio = Radio.new
    @contact_deck = ContactDeck.new @radio
    @learner = Learner.new @radio, @contact_deck
    @survivor = Survivor.new @radio, @contact_deck
  end

  def exist!
    puts "I am existing!"
    @learner.exist
    @survivor.exist

    puts "I am starting radio"
    @radio.start!
  end
end
