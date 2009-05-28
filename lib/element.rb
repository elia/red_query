
# represents one or more jQuery Elements
class Element < Array
  
  def [](index)
    Element.new(`jQuery(#{@jq_native}[#{index}])`)
  end
  
  def length
    `#{@jq_native}.length`
  end
  
  def size
    length
  end
  
  def each
    length.times { |i| yield self[i] }
  end
  
  def initialize(jq_native)
    `#{self}.__jq_native__ = #{jq_native}`
    @jq_native = jq_native
  end
  
  def self.from_html(html)
    Element.new(`jQuery(#{html}.__value__)`)
  end
  
  def append(elem)
    `#{@jq_native}.append(#{elem}.__jq_native__)`
  end
  
  def attr(name, value = nil)
    if value.nil?
      String.new(`#{@jq_native}.attr(#{name}.__value__)`)
    else
      `#{@jq_native}.attr(#{name}.__value__, #{value}.__value__)`
    end
  end
  
  def click(&block)
    callback = Proc.new { |native_event|
      block.call({
        :client_x => `#{native_event}.clientX`,
        :client_y => `#{native_event}.clientY`,
      })
    }
    `#{@jq_native}.click(function (event) {  
      return #{callback}.m$call(event);
    })`
  end  

  def css(key, value = nil, debug = false)
    if value.nil?
      String.new(`#{@jq_native}.css(#{key}.__value__)`)
    else
      `#{@jq_native}.css(#{key}.__value__, #{value}.__value__)`
    end
  end

  def find(css_selector)
    Element.new(`#{@jq_native}.find(#{css_selector}.__value__)`)
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
    `#{@jq_native}.focus()`
  end
  
  def html(value = nil)
    if value.nil?
      String.new(`#{@jq_native}.html()`)
    else
      `#{@jq_native}.html(#{value}.__value__)`
    end
  end
  
  def height
    `#{@jq_native}.height()`
  end
  
  def left(pos = nil)
    if pos.nil?
      `#{@jq_native}.offset().left`
    else
      `#{@jq_native}.left(#{pos})`
    end
  end

  def name
    attr("name")
  end
  
  def name=(value)
    attr("name", value)
  end
  
  def submit(&block)
    `#{@jq_native}.submit(function () { return #{block.call} })`
  end
  
  def top(pos = nil)
    if pos.nil?
      `#{@jq_native}.top()`
    else
      `#{@jq_native}.top(#{pos})`
    end
  end

  def value(str = nil)
    if str.nil?
      String.new(`#{@jq_native}.val()`)
    else
      `#{@jq_native}.val(str.__value__)`
    end
  end

  def width
    `#{@jq_native}.width()`
  end

end
