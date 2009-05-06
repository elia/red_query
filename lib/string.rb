
# useful web extensions for strings

class String
  
  # encodes string to URI-Component
  def to_uri_component
    String.new(`encodeURIComponent(#{self}.__value__)`)
  end
end
