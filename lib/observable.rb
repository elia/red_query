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
  
  def notify_observers(*args)
    @_observers.each { |o| o.update(*args) }
    @_observe_state = false
  end
end

