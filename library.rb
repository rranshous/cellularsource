
class Library

  def initialize
    @knowledge = Hash.new(:UNKNOWN)
  end

  def note question, answer
    @knowledge[question] = answer
  end

  def lookup question
    @knowledge[question]
  end

end
