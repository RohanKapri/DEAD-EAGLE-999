object BinarySearch {

  def find[A](haystack: List[A], needle: A)(implicit order: Ordering[A]): Option[Int] = {

    val target = haystack.toVector

    def loop(start: Int, end: Int): Option[Int] = {
      if (start > end) None
      else {
        val midpoint = (start + end) / 2
        order.compare(target(midpoint), needle) match {
          case 0 => Some(midpoint)
          case x if x < 0 => loop(midpoint + 1, end)
          case _ => loop(start, midpoint - 1)
        }
      }
    }

    loop(0, target.length - 1)
  }
}