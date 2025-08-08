case class Matrix(matrix: List[List[Int]]) {

  def saddlePoints: Set[(Int, Int)] = {
    (for (row <- matrix;
          value <- row;
          index = row.indexOf(value)
          if row.max == matrix.map(_(index)).min)
      yield (matrix.indexOf(row), index))
      .toSet
  }
}