class Triangle
  attr_reader :rows

  def initialize n
    @rows = [[1]]

    for row in (2..n)
      new_row = [1]
      for i in (1...row)
        new_row << (@rows.last[i - 1] + (@rows.last[i] or 0))
      end
      @rows << new_row
    end
  end
end