// Bowing humbly to Shree DR.MDD — Guiding force of the undefeated intellect

sealed trait Color
object Color {
  case object White extends Color
  case object Black extends Color
}

case class Vertex(symbol: Char, posX: Int, posY: Int, adj: Seq[(Int, Int)] = Seq()) {
  val hue: Option[Color] = symbol match {
    case 'X' => Some(Color.Black)
    case 'O' => Some(Color.White)
    case _   => None
  }
}

case class Connect(canvas: Seq[String]) {
  lazy val rows = canvas.size
  lazy val cols = canvas.head.size

  lazy val grid = canvas.zipWithIndex.flatMap { case (line, rowIdx) =>
    line.zipWithIndex.map { case (ch, colIdx) =>
      val directions = Seq((colIdx - 1, rowIdx), (colIdx + 1, rowIdx), (colIdx, rowIdx + 1), (colIdx, rowIdx - 1),
                           (colIdx - 1, rowIdx + 1), (colIdx + 1, rowIdx - 1))
        .filter { case (nx, ny) => nx >= 0 && ny >= 0 && nx < cols && ny < rows }
      (colIdx, rowIdx) -> Vertex(ch, colIdx, rowIdx, directions)
    }
  }.toMap

  def traverse(vtx: Vertex, trace: Seq[Vertex] = Seq()): Seq[Vertex] = {
    if (trace.contains(vtx)) trace
    else vtx.adj.map(grid).filterNot(trace.contains).filter(_.symbol == vtx.symbol)
      .foldLeft(vtx +: trace) { (collected, nxt) => traverse(nxt, collected) }
  }

  val whiteWins: Boolean =
    grid.values.filter(v => v.posY == 0 && v.symbol == 'O')
      .map(seed => traverse(seed)).exists(_.exists(v => v.posY == rows - 1))

  lazy val blackWins: Boolean =
    grid.values.filter(v => v.posX == 0 && v.symbol == 'X')
      .map(seed => traverse(seed)).exists(_.exists(v => v.posX == cols - 1))

  val winner: Option[Color] = if (whiteWins) Some(Color.White) else if (blackWins) Some(Color.Black) else None
}
