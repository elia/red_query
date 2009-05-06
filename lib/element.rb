
# represents one or more jQuery Elements
class Element
  def initialize(native)
    `#{self}.__native__ = #{native}`
    @native = native
  end
  
  def attr_get(name)
    String.new(`#{@native}.attr(#{name}.__value__)`)
  end
  
  def attr_set(name, value)
    `#{@native}.attr(#{name}.__value__, #{value}.__value__)`
  end
  
  def click(&block)
    `#{@native}.click(function () { return #{block.call} })`
  end  

  def css(key, value)
    `#{@native}.css(#{key}.__value__, #{value}.__value__)`
  end
  
  def focus
    `#{@native}.focus()`
  end
  
  def html(value)
    `#{@native}.html(#{value}.__value__)`
  end
  
  def name
    self.attr_get("name")
  end
  
  def name=(value)
    self.attr_set("name", value)
  end
  
  def submit(&block)
    `#{@native}.submit(function () { return #{block.call} })`
  end

  def value
    String.new(`#{@native}.val()`)
  end

end
