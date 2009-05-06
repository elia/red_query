require 'lib/element'

module Document
  def self.[](css_selector)
    self.query(css_selector)
  end
  
  def self.query(css_selector)
    `var result = jQuery(#{css_selector}.__value__)`
    count = `result.length`
    
    case count
    when 0
      return nil
    when 1
      return Element.new(`result`)
    else
      elements = []
      count.times { |i| 
        elements.push(Element.new(`jQuery(result[#{i}])`)) 
      }
      return elements
    end      
  end
  
  def self.ready?(&block)
    @ready_proc = block
  end
  
  def self.ready!
    @ready_proc.call
  end
end