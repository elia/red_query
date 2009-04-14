module Location
  def self.href(url)
    `location.href = #{url}.__value__`
  end
end