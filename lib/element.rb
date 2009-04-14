
# represents one or more jQuery Elements
class Element
  def initialize(native)
    `#{self}.__native__ = #{native}`
    @native = native
  end
  
  def focus
    `#{@native}.focus()`
  end

  def value
    # `console.log(#{@native})`
    String.new(`#{@native}.val()`)
  end
  
  def submit(&block)
    `#{@native}.submit(function () { return #{block.call} })`
  end
      
  def css(key, value)
    `#{@native}.css(#{key}.__value__, #{value}.__value__)`
  end
  
  def html(value)
    `#{@native}.html(#{value}.__value__)`
  end
end