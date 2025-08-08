object PascalsTriangle {
  private val triangle: Stream[Seq[Int]] = Stream.iterate(Seq(1)) {
    row => (row :+ 0, 0 +: row).zipped.map(_ + _)
  }

  def rows(numRows: Int): Seq[Seq[Int]] = triangle.take(numRows)
}