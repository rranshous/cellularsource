module MethodLocker
  def with_lock
    raise "no lock present" if @lock.nil?
    @lock.synchronize { return yield }
  end
end
