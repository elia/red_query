class Interval
  def initialize(time, &block)
    @timer = `setInterval(function () { #{block.call} }, #{time})`
  end
  
  def clear
    `clearInterval(#{@timer})`
  end
end