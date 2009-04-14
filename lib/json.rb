class JSON
  # ======= Parsing =============================================
  def self.parse(text)
    @native = `eval("("+#{text}.__value__+")");`
    return JSON.translate(@native)
  end
  
  def self.classify(native)
    type = String.new(`typeof #{native}`)
    if (type == 'object' && `!#{native}`)
      return "null"
    end
    if (type == 'object' && `Object.prototype.toString.apply(#{native}) === '[object Array]'`)
      return "array"
    end
    return type
  end
  
  def self.translate_array(native)
    natives = []
    `for (var i=0; i<#{native}.length; i++) { #{natives}.push(#{native}[i]); }`
    
    elems = []
    natives.each { |x|
      elems.push(JSON.translate(x))
    }
    return elems
  end
  
  def self.translate_object(native)
    stuff = []
    `for(var member in #{native}){#{stuff}.push(new Array($q(member), #{native}[member]));}`

    obj = {}
    stuff.each { |x|
      key = x[0]
      value = x[1]
      obj[key] = JSON.translate(value)
    }
    return obj
  end
  
  def self.translate(native)
    type = JSON.classify(native)
    if (type == 'string')
      return String.new(native)
    end
    
    if (type == 'number' || type == 'boolean')
      return native
    end
    
    if (type == 'array')
      return JSON.translate_array(native)
    end
    
    if (type == 'object')
      return JSON.translate_object(native)
    end
    
    return nil
  end
  
  # ======= Stringify =============================================
  def self.classify_ruby(stuff)
    if (stuff.class)
      return stuff.class.inspect
    end
    return "Boolean"
  end
  
  def self.stringify_string(str)
    `
    var cx = /[\\u0000\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]/g,
            escapable = /[\\\\\\"\\x00-\\x1f\\x7f-\\x9f\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]/g,
            gap,
            indent,
            meta = {    // table of character substitutions
                '\\b': '\\\\b',
                '\\t': '\\\\t',
                '\\n': '\\\\n',
                '\\f': '\\\\f',
                '\\r': '\\\\r',
                '"' : '\\\\"',
                '\\\\': '\\\\'
            },
            rep;

    
    function quote(string) {
      escapable.lastIndex = 0;
            return escapable.test(string) ?
                '"' + string.replace(escapable, function (a) {
                    var c = meta[a];
                    return typeof c === 'string' ? c :
                        '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                }) + '"' :
                '"' + string + '"';
        }
    
    `
    value = String.new(`quote(#{str}.__value__)`)
  end
  
  def self.stringify_array(stuff)
    stuff.map! { |elem| JSON.stringify(elem) }
    return '[' + stuff.join(',') + ']'
  end
  
  def self.stringify_hash(stuff)
    pairs = []
    stuff.each { |key, value| pairs.push(JSON.stringify(key) + ':' + JSON.stringify(value)) }
    return '{' + pairs.join(',') + '}'
  end
  
  def self.stringify(stuff)
    type = JSON.classify_ruby(stuff)
    
    if (type == "Numeric" || type == "Boolean")
      return stuff.inspect
    end
    
    if (type == "String")
      return JSON.stringify_string(stuff)
    end
    
    if (type == "Symbol")
      return JSON.stringify_string(stuff.to_s)
    end
    
    if (type == "Array")
      return JSON.stringify_array(stuff)
    end
    
    if (type == "Hash")
      return JSON.stringify_hash(stuff)
    end
    
    return "null"
  end
end
