class PascalsTriangle
  def self.rows(number_of_rows : Int32) : Array(Array(Int32))
    return [] of Array(Int32) if number_of_rows == 0

    triangle = [[1]] of Array(Int32)

    while triangle.size < number_of_rows
      last_row = triangle.last
      new_row = [1]

      last_row.each_cons(2) do |pair|
        new_row << pair[0] + pair[1]
      end

      new_row << 1
      triangle << new_row
    end

    triangle
  end
end