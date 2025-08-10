module Series
  def self.slices(series : String, slice_length : Int32) : Array(String)
    raise ArgumentError.new("Slice length cannot be greater than series length") if slice_length > series.size
    raise ArgumentError.new("Slice length must be positive") if slice_length <= 0

    series.chars.each_cons(slice_length).map(&.join).to_a
  end
end