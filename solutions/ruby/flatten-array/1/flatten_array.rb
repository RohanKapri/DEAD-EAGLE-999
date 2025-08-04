class FlattenArray
  def self.flatten array
    return [] if array.nil?
    return [array] unless array.is_a? Array

    array.inject [] do |flattened, elt|
      flattened += flatten elt
    end
  end
end