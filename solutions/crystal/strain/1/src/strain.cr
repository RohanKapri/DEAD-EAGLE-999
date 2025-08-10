class Array(T)
  # The keep method selects elements for which the block returns true
  def keep(&block : T -> Bool)
    result = [] of T
    self.each do |element|
      result << element if block.call(element)
    end
    result
  end

  # The discard method selects elements for which the block returns false
  def discard(&block : T -> Bool)
    result = [] of T
    self.each do |element|
      result << element unless block.call(element)
    end
    result
  end
end