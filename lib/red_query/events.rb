module Events
  # Defines allowed Events
  # eg:
  # class Foo
  #   include Events
  #   def initialize
  #     init_events :bar, :bat, :bitz
  #   end
  # end
  def init_events(*event_names)
    @events = {}
    event_names.each { |name| @events[name] = [] }
  end
  
  def add_events(*event_names)
    event_names.each { |name| 
      @events[name] = []
    }
  end
  
  def has_event?(event_name)
    !!@events[event_name]
  end
  
  # registers Proc for given _event_name_
  #
  # eg:
  # foo = Foo.new (Foo includes Events)
  # foo.on("bar") { |event| puts event[:stuff] }
  def on(event_name, &block)
    raise "invalid event '#{event_name.inspect}' on #{self.class}" if @events[event_name].nil?
    @events[event_name].push(block)
  end
  
  # fires event to all Procs registered for given _event_name_
  def fire(event_name, event = nil)
    raise "invalid event '#{event_name.inspect}' on #{self.class}" if @events[event_name].nil?
    @events[event_name].each { |block| block.call(event) }
  end
end
