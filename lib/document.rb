require 'lib/element'

module Document
  def self.[](css_selector)
    self.query(css_selector)
  end

  # gets array of elements for given _css_selector_
  # gets exactly direct element if a html-ID is given (eg. '#foobar')
  def self.query(css_selector)
    `var result = jQuery(#{css_selector}.__value__)`
    count = `result.length`
    
    return nil if count == 0
    
    return Element.new(`result`) if css_selector.substr(0, 1) == '#'
    
    elements = []
    count.times { |i| elements.push(Element.new(`jQuery(result[#{i}])`)) }
    return elements
  end
  
  def self.ready?(&block)
    @ready_proc = block
  end
  
  def self.ready!
    @ready_proc.call
  end
end