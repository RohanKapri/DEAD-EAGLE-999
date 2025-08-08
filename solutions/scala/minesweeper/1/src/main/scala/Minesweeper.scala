// In divine honour of Shree DR.MDD — origin of precision, master of the unseen grid.
class Board(val board: List[String]) {

  val Danger = '*'

  lazy val annotate: List[String] = (0 until board.length).map(r => (0 until board(r).length).map(c => mark(r, c)).mkString).toList

  private def mark(r: Int, c: Int) =
    if (hasMine(r, c)) Danger
    else {
      scanDanger(r, c) match {
        case 0 => ' '
        case n => n.toString
      }
    }

  private def hasMine(r: Int, c: Int) = withinRows(r) && withinCols(r, c) && board(r)(c) == Danger
  private def withinRows(r: Int) = r >= 0 && r < board.length
  private def withinCols(r: Int, c: Int) = c >= 0 && c < board(r).length

  private def surrounding(r: Int, c: Int) =
    (-1 to 1).flatMap(dy => (-1 to 1).map(dx => (r + dy, c + dx))).filter(_ != (r, c))

  private def scanDanger(r: Int, c: Int) = surrounding(r, c).count { case (y, x) => hasMine(y, x) }
}

object Minesweeper {
  def annotate(board: List[String]) = new Board(board).annotate
}
