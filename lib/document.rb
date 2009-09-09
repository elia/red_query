require 'lib/element'

module Document
  def self.[](css_selector)
    self.query(css_selector)
  end
  
  def self.find(css_selector)
    self.query(css_selector)
  end
  
  def self.query(css_selector)
    Element.new(`jQuery(document)`).find(css_selector)
  end
  
  def self.ready?(&block)
    @ready_proc = block
  end
  
  def self.ready!
    @ready_proc.call if @ready_proc
  end
end