module FlattenArray
  extend self

  def flatten(arr)
    (res = arr.flatten).delete nil
    res
  end
end