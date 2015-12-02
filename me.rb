require 'radio'
require 'me/learner'
require 'me/survivor'

class Me

  def initialize
    @radio = Radio.new
    @learner = Learner.new @radio
    @survivor = Survivor.new @radio
  end

  def exist!
    @learner.exist
    @survivor.exist

    @radio.start!
  end
end
