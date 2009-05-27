class Browser
  @@history = nil
  
  def ie?
    return `jQuery.browser.msie`
  end
  
  def self.history
    if @@history.nil?
      if `jQuery.browser.msie && parseInt(jQuery.browser.version) < 8`
        @@history = ::HistoryIE.new
      else
        @@history = ::HistoryNormal.new
      end
    end
    
    @@history
  end
end
