module Ajax
  def self.request(options)
    options[:data] = options[:data] || {}
    params = options[:data].to_query_string
    success_callback = Proc.new { |text| options[:success].call(String.new(text)) }
    error_callback = Proc.new { |msg| options[:problem].call(String.new(msg)) }
    
    `jQuery.ajax({
      url:#{options[:url]}.__value__, 
      type:#{options[:method]}.__value__, 
      data:#{params}.__value__,
      success: function(msg) { return #{success_callback}.m$call(msg); },
      error: function(xhr,msg) { return #{error_callback}.m$call(msg); }
    })`
  end
  
  def self.requestJSON(options)
    orig_success = options[:success]
    options[:success] = Proc.new { |text| orig_success.call(JSON.parse(text)) }
    
    self.request(options)
  end
  
  class ::Hash
    # call-seq:
    #   hsh.to_query_string -> string
    # 
    # Returns a string representing _hsh_ formatted as HTTP data.
    # 
    def to_query_string(base = '')
      query_string = []
      self.each do |k,v|
        if `#{v} === false` 
          v = "false"
        end
        if `#{v} === true` 
          v = "true"
        end
        next if v.nil?
        k = base.empty? ? k.to_s : "%s[%s]" % [base,k]
        case v
        when Hash
          result = v.to_query_string(k)
        when Array
          qs = {}
          `for(var i=0,l=v.length;i<l;i++){#{qs[i] = v[i]}}`
          #v.each_with_index do |v,i|
          #  qs[i] = v
          #end
          result = qs.to_query_string(k)
        else
          result = "%s=%s" % [k, `$q(encodeURIComponent(v))`]
        end
        query_string.push(result)
      end
      return query_string.join('&')
    end
  end
end