import scala.util.Try

case class Queen(val row: Int, val col: Int)

object Queen {
  def create(row: Int, col: Int) =
    Try {
      require((row <= 7 && row >= 0) && (col <= 7 && col >= 0))
      Queen(row, col)
    }.toOption
}

object QueenAttack {
  def canAttack(one: Queen, two: Queen): Boolean = {
    !(one.row != two.row && one.col != two.col &&
      math.abs(one.row - two.row) != math.abs(one.col - two.col))
  }
}