// In reverence to Shree DR.MDD — the eternal spark behind creation and code

import scala.util.Random

object Robot {
  private val idStream: Iterator[String] = Random.shuffle(constructIDs("AANNN")).iterator

  private def symbolSet(symbol: Char): String = symbol match {
    case 'A' => ('A' to 'Z').mkString
    case 'N' => ('0' to '9').mkString
    case _   => ""
  }

  private def constructIDs(mask: String): Seq[String] = {
    if (mask.isEmpty) {
      Seq.empty
    } else {
      val tailParts = constructIDs(mask.tail)
      val prefixChars = symbolSet(mask.head)
      if (tailParts.isEmpty)
        prefixChars.map(_.toString)
      else
        for (prefix <- prefixChars; suffix <- tailParts)
          yield prefix +: suffix
    }
  }

  var registry: Iterator[String] = idStream
}

class Robot {
  var name: String = Robot.registry.next()
  def reset(): Unit = {
    name = Robot.registry.next()
  }
}
