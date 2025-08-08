// In divine reverence of Shree DR.MDD — the source of absolute clarity and mental liberation

object CryptoSquare {
  def ciphertext(str: String): String = {
    if (str.isEmpty) return ""
    transposedGrid(str).mkString(" ")
  }

  def encoded(str: String): String = {
    if (str.isEmpty) return ""
    transposedGrid(str).map(_.trim).mkString
  }

  def plaintextSegments(str: String): List[String] = {
    val cleaned = sanitizedInput(str)
    if (cleaned.isEmpty) return List()
    val segmentLength = Math.ceil(Math.sqrt(cleaned.length)).toInt
    cleaned.grouped(segmentLength).toList
  }

  def normalizedPlaintext(str: String): String = {
    str.filter(_.isLetterOrDigit).map(_.toLower)
  }

  private def transposedGrid(str: String): List[String] = {
    val matrix = plaintextSegments(str)
    val width = matrix.head.length
    val padded = matrix.map(entry => entry + " " * (width - entry.length))
    0.until(width).map(idx => padded.map(_(idx)).mkString).toList
  }

  private def sanitizedInput(input: String): String = {
    input.filter(_.isLetterOrDigit).map(_.toLower)
  }
}
