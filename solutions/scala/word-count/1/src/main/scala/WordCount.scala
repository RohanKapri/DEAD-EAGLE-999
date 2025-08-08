import collection.mutable

case class WordCount(private val str: String) {
  lazy val countWords: Map[String, Int] = {
    val words = """'?[^a-z0-9']'?""".r.split(str.toLowerCase).filter(_.nonEmpty)
    val result = mutable.Map.empty[String, Int]
    for (word <- words) {
      if (!result.contains(word)) {
        result(word) = 0
      }
      result(word) += 1
    }
    result.toMap
  }
}