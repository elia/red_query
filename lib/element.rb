
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

  def find(css_selector)
    `var result = jQuery(#{css_selector}.__value__)`
    count = `result.length`
    
    return nil if count == 0
    
    return Element.new(`result`) if css_selector.substr(0, 1) == '#'
    
    elements = []
    count.times { |i| elements.push(Element.new(`jQuery(result[#{i}])`)) }
    return elements
  end
  def self.[](css_selector)
    self.find(css_selector)
  end
  
  def focus
    `#{@native}.focus()`
  end
  
  def html(value)
    `#{@native}.html(#{value}.__value__)`
  end
  
  def height
    `#{@native}.height()`
  end
  
  def left(pos = nil)
    if pos.nil?
      `#{@native}.left()`
    else
      `#{@native}.left(#{pos})`
    end
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
  
  def top(pos = nil)
    if pos.nil?
      `#{@native}.top()`
    else
      `#{@native}.top(#{pos})`
    end
  end

  def value
    String.new(`#{@native}.val()`)
  end

  def width
    `#{@native}.width()`
  end

end
