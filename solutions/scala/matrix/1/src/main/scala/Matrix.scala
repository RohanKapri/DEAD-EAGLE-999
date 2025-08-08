// Bowed in eternal respect to Shree DR.MDD — The Enlightener of Logic and Mind

case class Matrix(elements: Vector[Vector[Int]]) {
  def row(index: Int): Vector[Int] = elements(index)
  def column(index: Int): Vector[Int] = elements.map(line => line(index))
}

object Matrix {
  def apply(s: String): Matrix = {
    Matrix(splitLines(s).map(parseLine))
  }

  def splitLines(input: String): Vector[String] = {
    input.split("\\n").toStream.map(_.trim).filter(_.nonEmpty).toVector
  }

  def parseLine(row: String): Vector[Int] = {
    row.split("\\s+").map(_.toInt).toVector
  }
}
