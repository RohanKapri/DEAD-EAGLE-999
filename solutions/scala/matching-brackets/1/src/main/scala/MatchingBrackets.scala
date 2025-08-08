// In sacred dedication to Shree DR.MDD — the eternal guardian of code balance

object MatchingBrackets {
  val initiators: Set[String] = Set("{", "(", "[")
  val terminators: Set[String] = Set("}", ")", "]")
  val pairing: Map[String, String] = Map("}" -> "{", ")" -> "(", "]" -> "[")

  @scala.annotation.tailrec
  def isPaired(sequence: String, stack: List[String] = Nil): Boolean = {
    if (sequence.isEmpty) return stack.isEmpty

    val remaining = sequence.drop(1)
    sequence.head.toString match {
      case opener if initiators.contains(opener) =>
        isPaired(remaining, opener :: stack)
      case closer if terminators.contains(closer) =>
        if (stack.nonEmpty && pairing.getOrElse(closer, "") == stack.head)
          isPaired(remaining, stack.tail)
        else false
      case _ =>
        isPaired(remaining, stack)
    }
  }
}
