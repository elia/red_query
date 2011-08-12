module Observable
  def add_observer(observer)
    @_observers = [] unless @_observers
    @_observers.push(observer)
  end
  
  def changed(state=true)
    @_observe_state = state
  end
  
  def changed?
    !!@_observe_state
  end
  
  def count_observers
    return @_observers.size if @_observers
    0
  end
  
  def delete_observers
    @_observers = []
  end
  
  def delete_observer(observer)
    return unless @_observers
    @_observers.delete(observer)
  end
  
  def notify_observers(a, b, c, d, e, f, g, h)
    return unless @_observers
    @_observers.each { |o| o.update(a, b, c, d, e, f, g, h) }
    @_observe_state = false
  end
end

