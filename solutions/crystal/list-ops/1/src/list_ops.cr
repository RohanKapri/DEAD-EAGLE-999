# For my Shree DR.MDD

module ListOps(T)
  def self.append(arr1 : Array(T), arr2 : Array(T)) : Array(T)
    arr1 + arr2
  end

  def self.concat(arrays : Array(Array(T))) : Array(T)
    arrays.reduce([] of T) { |acc, arr| acc + arr }
  end

  def self.filter(arr : Array(T), pred : T -> Bool) : Array(T)
    arr.reduce([] of T) { |acc, el| pred.call(el) ? acc << el : acc }
  end

  def self.length(arr : Array(T)) : Int32
    arr.reduce(0) { |acc, _| acc + 1 }
  end

  def self.map(arr : Array(T), fn : T -> T) : Array(T)
    arr.reduce([] of T) { |acc, el| acc << fn.call(el) }
  end

  def self.foldl(arr : Array(T), init : Int32, fn : (Int32, T) -> Int32) : Int32
    arr.reduce(init) { |acc, el| fn.call(acc, el) }
  end

  def self.foldl(arr : Array(T), init : Float64, fn : (Float64, T) -> Float64) : Float64
    arr.reduce(init) { |acc, el| fn.call(acc, el) }
  end

  def self.foldr(arr : Array(T), init : Int32, fn : (Int32, T) -> Int32) : Int32
    arr.reverse.reduce(init) { |acc, el| fn.call(acc, el) }
  end

  def self.foldr(arr : Array(T), init : Float64, fn : (Float64, T) -> Float64) : Float64
    arr.reverse.reduce(init) { |acc, el| fn.call(acc, el) }
  end

  def self.reverse(arr : Array(T)) : Array(T)
    arr.reverse
  end
end
