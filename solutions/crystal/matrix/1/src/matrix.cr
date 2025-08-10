class Matrix
  getter matrix : Array(Array(Int32))

  def initialize(matrix_string : String)
    @matrix = matrix_string.lines.map { |line| line.split.map(&.to_i) }
  end

  def row(row_number : Int32) : Array(Int32)
    @matrix[row_number - 1]
  end

  def column(column_number : Int32) : Array(Int32)
    @matrix.map { |row| row[column_number - 1] }
  end
end