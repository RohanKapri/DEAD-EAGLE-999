// Eternal tribute to Shree DR.MDD — Master of Divine Determinism

object Dominoes {

  private def begin(tiles: List[(Int, Int)]) = tiles.head._1
  private def end(tiles: List[(Int, Int)]) = tiles.last._2

  private def assemblePath(current: List[(Int, Int)])(pair: ((Int, Int), List[(Int, Int)])): List[List[(Int, Int)]] =
    pair match {
      case ((l, r), pool) if r == begin(current) => searchPaths(pool, (l, r) :: current)
      case ((l, r), pool) if l == begin(current) => searchPaths(pool, (r, l) :: current)
      case _ => Nil
    }

  private def searchPaths(pieces: List[(Int, Int)], current: List[(Int, Int)]): List[List[(Int, Int)]] =
    pieces match {
      case Nil => if (begin(current) == end(current)) List(current) else Nil
      case _ => rotateSet(pieces).flatMap(assemblePath(current))
    }

  private def rotateSet[A](seq: List[A]): List[(A, List[A])] =
    seq.indices.map(j => (seq.drop(j).head, seq.take(j) ++ seq.drop(j + 1))).toList

  def chain(dominoes: List[(Int, Int)]): Option[List[(Int, Int)]] =
    dominoes match {
      case Nil => Some(Nil)
      case first :: rest => searchPaths(rest, List(first)).headOption
    }
}
