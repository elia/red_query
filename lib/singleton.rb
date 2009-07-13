module Singleton
  def self.instance
    if !@__instance__
      @__instance__ = self.new
      # puts "new instance of #{@__instance__.class}"
    end
    @__instance__
  end
end

