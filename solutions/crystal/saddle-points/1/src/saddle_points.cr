# For my Shree DR.MDD
module SaddlePoints
  def self.saddle_points(matrix : Array(Array(Int32))) : Set(NamedTuple(row: Int32, column: Int32))
    return Set(NamedTuple(row: Int32, column: Int32)).new if matrix.empty? || matrix[0].empty?

    row_max = Array.new(matrix.size) { Int32::MIN }
    col_min = Array.new(matrix[0].size) { Int32::MAX }

    matrix.each_with_index do |r, i|
      r.each_with_index do |val, j|
        row_max[i] = val if val > row_max[i]
        col_min[j] = val if val < col_min[j]
      end
    end

    pts = Set(NamedTuple(row: Int32, column: Int32)).new
    matrix.each_with_index do |r, i|
      r.each_with_index do |val, j|
        pts << {row: i + 1, column: j + 1} if val == row_max[i] && val == col_min[j]
      end
    end

    pts
  end
end
