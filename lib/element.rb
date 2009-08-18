
# represents one or more jQuery Elements
class Element < Array
  
  @@element_id_count = 0
  
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
  
  # returns attr('id') of element. if none exists, one will be assigned
  def id
    id = attr('id')
    return id unless id == ""
    
    @@element_id_count += 1
    id = "red_query_elem_#{@@element_id_count}"
    attr('id', id)
    return id
  end
  
  def append(elem)
    `#{@jq_native}.append(#{elem}.__jq_native__)`
  end
  
  def prepend(elem)
    `#{@jq_native}.prepend(#{elem}.__jq_native__)`
  end

  def after(elem)
    `#{@jq_native}.after(#{elem}.__jq_native__)`
  end
  
  def before(elem)
    `#{@jq_native}.before(#{elem}.__jq_native__)`
  end
  
  def attr(name, value = nil)
    if value.nil?
      String.new(`#{@jq_native}.attr(#{name}.__value__)`)
    else
      `#{@jq_native}.attr(#{name}.__value__, #{value}.__value__)`
    end
  end
  
  def click(&block)
    callback = mouse_event(block)
    `#{@jq_native}.click(function (event) { return #{callback}.m$call(event); })`
  end  
  
  def add_class(css_class)
    `#{@jq_native}.addClass(#{css_class}.__value__)`
  end

  def has_class(css_class)
    `#{@jq_native}.hasClass(#{css_class}.__value__)`
  end
  
  def remove_class(css_class)
    `#{@jq_native}.removeClass(#{css_class}.__value__)`
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
    throw "[red_query] not found: #{css_selector}" unless result
    # return nil unless result
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
  
  def key_event(block)
    Proc.new { |native_event|
      block.call({
        :code  => `#{native_event}.keyCode`,
        :shift => `#{native_event}.shiftKey`,
        :ctrl  => `#{native_event}.ctrlKey`,
        :meta  => `#{native_event}.metaKey`,
        :prevent => Proc.new { `#{native_event}.preventDefault()` },
      })
    }
  end
  
  def key_down(&block)
    callback = key_event(block)
    `#{@jq_native}.keydown(function (event) { return #{callback}.m$call(event); })`
  end
  
  def key_press(&block)
    callback = key_event(block)
    `#{@jq_native}.keydown(function (event) { return #{callback}.m$call(event); })`
  end
  
  def key_up(&block)
    callback = key_event(block)
    `#{@jq_native}.keydown(function (event) { return #{callback}.m$call(event); })`
  end
  
  def mouse_event(block)
    Proc.new { |native_event|
      # `console.log(#{native_event})`
      block.call({
        :client_x => `#{native_event}.clientX`,
        :client_y => `#{native_event}.clientY`,
        :page_x => `#{native_event}.pageX`,
        :page_y => `#{native_event}.pageY`,
        :screen_x => `#{native_event}.screenX`,
        :screen_y => `#{native_event}.screenY`,
        :prevent => Proc.new { `#{native_event}.preventDefault()` },
      })
    }
  end
  
  def mouse_down(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mousedown(function (event) { return #{callback}.m$call(event); })`
  end
  
  def mouse_up(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mouseup(function (event) { return #{callback}.m$call(event); })`
  end
  
  def mouse_enter(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mouseenter(function (event) { return #{callback}.m$call(event); })`
  end
  
  def mouse_leave(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mouseleave(function (event) { return #{callback}.m$call(event); })`
  end
  
  def mouse_over(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mouseover(function (event) { return #{callback}.m$call(event); })`
  end

  def mouse_move(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mousemove(function (event) { return #{callback}.m$call(event); })`
  end

  def mouse_out(&block)
    callback = mouse_event(block)
    `#{@jq_native}.mouseout(function (event) { return #{callback}.m$call(event); })`
  end

  def name
    attr("name")
  end
  
  def name=(value)
    attr("name", value)
  end
  
  def remove
    `#{@jq_native}.remove()`
  end
  
  def submit(&block)
    `#{@jq_native}.submit(function () { return #{block.call} })`
  end
  
  def top(pos = nil)
    if pos.nil?
      `#{@jq_native}.offset().top`
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
