require 'thread'

class Library

  def initialize
    @knowledge = Hash.new(:UNKNOWN)
    @lock = Mutex.new
  end

  def note question, answer
    puts "library noting: #{question} => #{answer}"
    @lock.synchronize { @knowledge[question] = answer }
  end

  def lookup question
    puts "library lookup up: #{question}"
    answer = nil
    @lock.synchronize { answer = @knowledge[question] }
    puts "library answered [#{question}]: #{answer}"
    return answer
  end

end
