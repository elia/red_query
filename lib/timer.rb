class Timer
  def initialize(time, &block)
    @timer = `setTimeout(function () { #{block.call} }, #{time})`
  end
  
  def clear
    `clearTimeout(#{@timer})`
  end
end