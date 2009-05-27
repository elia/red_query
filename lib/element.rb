
# represents one or more jQuery Elements
class Element < Array
  
  def [](index)
    Element.new(`jQuery(#{@native}[#{index}])`)
  end
  
  def length
    `#{@native}.length`
  end
  
  def size
    length
  end
  
  def each
    length.times { |i| yield self[i] }
  end
  
  def initialize(native)
    `#{self}.__native__ = #{native}`
    @native = native
  end
  
  def self.from_html(html)
    Element.new(`jQuery(#{html}.__value__)`)
  end
  
  def append(elem)
    `#{@native}.append(#{elem}.__native__)`
  end
  
  def attr(name, value = nil)
    if value.nil?
      String.new(`#{@native}.attr(#{name}.__value__)`)
    else
      `#{@native}.attr(#{name}.__value__, #{value}.__value__)`
    end
  end
  
  def click(&block)
    callback = Proc.new { |native_event|
      block.call({
        :client_x => `#{native_event}.clientX`,
        :client_y => `#{native_event}.clientY`,
      })
    }
    `#{@native}.click(function (event) {  
      return #{callback}.m$call(event);
    })`
  end  

  def css(key, value = nil, debug = false)
    if value.nil?
      String.new(`#{@native}.css(#{key}.__value__)`)
    else
      `#{@native}.css(#{key}.__value__, #{value}.__value__)`
    end
  end

  def find(css_selector)
    Element.new(`#{@native}.find(#{css_selector}.__value__)`)
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
      `#{@native}.offset().left`
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
