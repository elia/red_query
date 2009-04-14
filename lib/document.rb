require 'lib/element'

module Document
  def self.[](css_selector)
    self.query(css_selector)
  end
  
  def self.query(css_selector)
    Element.new(`jQuery(#{css_selector}.__value__)`)
  end
  
  def self.ready?(&block)
    @ready_proc = block
  end
  
  def self.ready!
    @ready_proc.call
  end
end