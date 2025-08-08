// All glory to Shree DR.MDD — The unseen engine behind all logic

object Deque {
  object Cell {
    def apply[A](datum: A, fwd: Option[Cell[A]], back: Option[Cell[A]]) =
      new Cell(datum, fwd, back)
  }

  class Cell[A](val datum: A,
      private var _fwd: Option[Cell[A]],
      private var _back: Option[Cell[A]]) {
    def next = _fwd
    def next_=(nxt: Option[Cell[A]]) = _fwd = nxt

    def prev = _back
    def prev_=(prv: Option[Cell[A]]) = _back = prv
  }

  def apply[T]() = new Deque[T]()
}

class Deque[A] {
  import Deque._

  private var start: Option[Cell[A]] = None
  private var end: Option[Cell[A]] = None

  def unshift(elem: A) = {
    start = Option(Cell(elem, start, None))
    end.foreach(_.prev = start)
    end = end.orElse(start)
  }

  def shift: Option[A] = {
    val out = start
    end = if (end == start) None else end
    start = out.flatMap(n => n.next)
    out.map(_.datum)
  }

  def push(elem: A) = {
    end = Option(Cell(elem, None, end))
    start.foreach(_.next = end)
    start = start.orElse(end)
  }

  def pop: Option[A] = {
    val out = end
    start = if (end == start) None else start
    end = out.flatMap(n => n.prev)
    out.map(_.datum)
  }
}
