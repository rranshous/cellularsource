class Object
  def and
    yield self
  end
end

def nil.and
end
