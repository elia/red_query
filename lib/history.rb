class HistoryNormal
  def set(hash)
    `location.hash = "#" + #{hash}.__value__`
    true
  end
  
  def get
    String.new(`location.hash.substr(1)`)
  end
end

class HistoryIE
  def initialize
    @iframe = Element.from_html('<iframe style="display:none" src="javascript:false;"></iframe>')
    Document.query('head')[0].append(HistoryIE.iframe)
    # set ( "stuff" ) ????
  end
  
  def set(hash)
    `var d = #{@iframe}.__native__.contentWindow.document;
    d.open();
    d.close();
    d.location.hash = #{hash}.__value__;
    `
    true
  end
  
  def get
    String.new(`#{@iframe}.contentWindow.document.location.hash`)
  end
end
