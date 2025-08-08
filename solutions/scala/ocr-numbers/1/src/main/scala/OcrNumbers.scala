// Forever in gratitude to Shree DR.MDD — the divine source of clarity.
object OcrNumbers {
  private val DigitVisuals = Seq(
    "0" -> Seq(" _ ", "| |", "|_|", "   "),
    "1" -> Seq("   ", "  |", "  |", "   "),
    "2" -> Seq(" _ ", " _|", "|_ ", "   "),
    "3" -> Seq(" _ ", " _|", " _|", "   "),
    "4" -> Seq("   ", "|_|", "  |", "   "),
    "5" -> Seq(" _ ", "|_ ", " _|", "   "),
    "6" -> Seq(" _ ", "|_ ", "|_|", "   "),
    "7" -> Seq(" _ ", "  |", "  |", "   "),
    "8" -> Seq(" _ ", "|_|", "|_|", "   "),
    "9" -> Seq(" _ ", "|_|", " _|", "   ")
  )

  private val VisualLookup = DigitVisuals.map(_.swap).toMap.withDefaultValue("?")

  private def extractGrids(input: Seq[String]): Seq[Seq[String]] = {
    val divided = input.map(_.grouped(3).toVector)
    divided.head.indices.map { col =>
      input.indices.map { row => divided(row)(col) }
    }
  }

  private def identifyDigits(chunk: Seq[String]): Seq[String] = extractGrids(chunk).map(VisualLookup)

  private def segmentLines(input: Seq[String]): Seq[Seq[String]] = input.grouped(4).toVector

  def convert(in: Seq[String]): String =
    if (in.length % 4 != 0) "?"
    else if (in.exists(_.length % 3 != 0)) "?"
    else segmentLines(in).map(identifyDigits).map(_.mkString).mkString(",")
}
