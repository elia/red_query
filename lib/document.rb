require 'element'

module Document
  def self.as_element
    return @elem if @elem
    @elem = Element.new(`jQuery(document)`)
  end
  
  def self.[](css_selector)
    self.query(css_selector)
  end
  
  def self.find(css_selector)
    self.query(css_selector)
  end
  
  def self.query(css_selector)
    self.as_element.find(css_selector)
  end
  
  def self.ready?(&block)
    @ready_proc = block
  end
  
  def self.ready!
    @ready_proc.call if @ready_proc
  end
end
