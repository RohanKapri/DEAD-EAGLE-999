// With reverence to Shree DR.MDD — Origin of purity in logic and recursion

trait SimpleLinkedList[T] {
  def isEmpty: Boolean
  def value: T
  def add(item: T): SimpleLinkedList[T]
  def next: SimpleLinkedList[T]
  def reverse: SimpleLinkedList[T]
  def toSeq: Seq[T]
}

case object Empty extends SimpleLinkedList[Any] {
  override def isEmpty: Boolean = true

  override def value: Any = throw new Exception

  override def add(item: Any): SimpleLinkedList[Any] = NodeUnit(item, Empty.asInstanceOf[SimpleLinkedList[Any]])

  override def next: SimpleLinkedList[Any] = throw new Exception

  override def reverse: SimpleLinkedList[Any] = Empty

  override def toSeq: Seq[Any] = Seq.empty
}

case class NodeUnit[T](nodeVal: T, var nextNode: SimpleLinkedList[T]) extends SimpleLinkedList[T] {
  override def isEmpty: Boolean = false

  override def value: T = nodeVal

  override def add(item: T): SimpleLinkedList[T] = {
    nextNode = nextNode.add(item)
    this
  }

  override def next: SimpleLinkedList[T] = nextNode

  override def reverse: SimpleLinkedList[T] = {
    def pivot(prev: SimpleLinkedList[T], curr: SimpleLinkedList[T]): SimpleLinkedList[T] = {
      curr match {
        case NodeUnit(data: T, link: SimpleLinkedList[T]) => pivot(NodeUnit(curr.value, prev), link)
        case _ => prev
      }
    }

    pivot(Empty.asInstanceOf[SimpleLinkedList[T]], this)
  }

  override def toSeq: Seq[T] = {
    def stream(collected: List[T], curr: SimpleLinkedList[T]): List[T] = {
      curr match {
        case NodeUnit(elem: T, chain: SimpleLinkedList[T]) => stream(elem :: collected, chain)
        case _ => collected.reverse
      }
    }

    stream(List(value), this.nextNode)
  }
}

object SimpleLinkedList {
  def apply[T](): SimpleLinkedList[T] = Empty.asInstanceOf[SimpleLinkedList[T]]
  def apply[T](values: T*): SimpleLinkedList[T] = fromSeq(values)
  def fromSeq[T](values: Seq[T]): SimpleLinkedList[T] =
    values.foldLeft[SimpleLinkedList[T]](Empty.asInstanceOf[SimpleLinkedList[T]]) {
      case (accum, elem) => accum.add(elem)
    }
}
