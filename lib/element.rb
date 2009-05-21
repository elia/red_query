
# represents one or more jQuery Elements
class Element
  def initialize(native)
    `#{self}.__native__ = #{native}`
    @native = native
  end
  
  def attr(name, value = nil)
    if value.nil?
      String.new(`#{@native}.attr(#{name}.__value__)`)
    else
      `#{@native}.attr(#{name}.__value__, #{value}.__value__)`
    end
  end
  
  def click(&block)
    `#{@native}.click(function () { return #{block.call} })`
  end  

  def css(key, value = nil, debug = false)
    if value.nil?
      String.new(`#{@native}.css(#{key}.__value__)`)
    else
      `#{@native}.css(#{key}.__value__, #{value}.__value__)`
    end
  end

  # returns nil if _css_selector_ has no match
  # returns matching element if _css_selector_ starts with "#"
  # returns array of matching elements if _css_selector_ has matches
  def find(css_selector)
    `var result = #{@native}.find(#{css_selector}.__value__)`
    count = `result.length`
    
    return nil if count == 0
    
    return Element.new(`result`) if css_selector.substr(0, 1) == '#'
    
    elements = []
    count.times { |i| elements.push(Element.new(`jQuery(result[#{i}])`)) }
    return elements
  end
  
  def find_first(css_selector)
    result = find(css_selector)
    return nil if result.nil?
    result[0]
  end
  
  def self.[](css_selector)
    self.find(css_selector)
  end
  
  def focus
    `#{@native}.focus()`
  end
  
  def html(value = nil)
    if value.nil?
      String.new(`#{@native}.html()`)
    else
      `#{@native}.html(#{value}.__value__)`
    end
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
    attr("name")
  end
  
  def name=(value)
    attr("name", value)
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

  def value(str = nil)
    if str.nil?
      String.new(`#{@native}.val()`)
    else
      `#{@native}.val(str.__value__)`
    end
  end

  def width
    `#{@native}.width()`
  end

end
