class Browser
  @@history = nil
  
  def self.ie?
    return `jQuery.browser.msie`
  end
  
  def self.version
    `parseInt(jQuery.browser.version)`
  end
  
  def self.history
    if @@history.nil?
      if Browser.ie? && Browser.version < 8
        @@history = ::HistoryIE.new
      else
        @@history = ::HistoryNormal.new
      end
    end
    
    @@history
  end
end
