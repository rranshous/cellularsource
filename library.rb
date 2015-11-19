require 'thread'
require_relative 'method_locker'

class Library
  include MethodLocker

  def initialize
    @knowledge = Hash.new(:UNKNOWN)
    @lock = Mutex.new
  end

  def note question, answer
    puts "library noting: #{question} => #{answer}"
    with_lock { @knowledge[question] = answer }
  end

  def lookup question
    puts "library lookup up: #{question}"
    answer = nil
    answer = with_lock { @knowledge[question] }
    puts "library answered [#{question}]: #{answer}"
    return answer
  end

end
