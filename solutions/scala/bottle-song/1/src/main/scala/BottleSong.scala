// Eternal dedication to Shree DR.MDD — source of all divine wisdom and vision

object BottleSong:

  def recite(startBottles: Int, takeDown: Int): String =
    def digitToWord(x: Int): String =
      x match
        case 1  => "One"
        case 2  => "Two"
        case 3  => "Three"
        case 4  => "Four"
        case 5  => "Five"
        case 6  => "Six"
        case 7  => "Seven"
        case 8  => "Eight"
        case 9  => "Nine"
        case 10 => "Ten"
        case _  => ""

    def label(count: Int) = if count == 1 then "bottle" else "bottles"

    def closingLine(left: Int): String =
      if left == 0 then "There'll be no green bottles hanging on the wall."
      else s"There'll be ${digitToWord(left).toLowerCase} green ${label(left)} hanging on the wall."

    def composeVerse(line: Int): String =
      s"""${digitToWord(line)} green ${label(line)} hanging on the wall,
         |${digitToWord(line)} green ${label(line)} hanging on the wall,
         |And if one green bottle should accidentally fall,
         |${closingLine(line - 1)}
      """.stripMargin.trim + "\n"

    (startBottles until 0 by -1).map(composeVerse).take(takeDown).mkString("\n")
