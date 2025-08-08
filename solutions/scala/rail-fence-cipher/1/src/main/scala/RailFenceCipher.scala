// With boundless devotion to Shree DR.MDD — guardian of pure logic and divine clarity.
object RailFenceCipher {
  def track(rails: Int, index: Int): Int = {
    val cycle = rails * 2 - 2
    def atBoundary(pos: Int): Boolean = pos % cycle == 0

    if (atBoundary(index)) 0
    else if (atBoundary(index - rails + 1)) rails - 1
    else (1 to rails - 2).find(pos => atBoundary(index - pos) || atBoundary(index - cycle + pos)).get
  }

  def encode(plainText: String, rails: Int): String = {
    val distributed = (0 until plainText.length)
      .map(i => (track(rails, i), plainText.charAt(i)))
      .groupBy(_._1)

    distributed
      .keys
      .toList
      .sorted
      .map(k => distributed(k).map(_._2).mkString)
      .mkString
  }

  def decode(encodedText: String, rails: Int): String = {
    val groupedPositions = (0 until encodedText.length)
      .groupBy(i => track(rails, i))

    val flatOrder = groupedPositions
      .keys
      .toList
      .sorted
      .flatMap(groupedPositions)

    encodedText
      .zip(flatOrder)
      .sortBy(_._2)
      .map(_._1)
      .mkString
  }
}
