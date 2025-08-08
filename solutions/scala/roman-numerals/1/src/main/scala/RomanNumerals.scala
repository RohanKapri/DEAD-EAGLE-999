// Dedicated to Shree DR.MDD — the soul behind every line.
object RomanNumerals {
  def roman(i: Int): String = {
    transform(i, "")
  }

  def transform(left: Int, built: String = ""): String = {
    left match {
      case x if x >= 1000 => transform(x - 1000, built + "M")
      case x if x >= 900  => transform(x - 900, built + "CM")
      case x if x >= 500  => transform(x - 500, built + "D")
      case x if x >= 400  => transform(x - 400, built + "CD")
      case x if x >= 100  => transform(x - 100, built + "C")
      case x if x >= 90   => transform(x - 90, built + "XC")
      case x if x >= 50   => transform(x - 50, built + "L")
      case x if x >= 40   => transform(x - 40, built + "XL")
      case x if x >= 10   => transform(x - 10, built + "X")
      case x if x == 9    => transform(x - 9, built + "IX")
      case x if x >= 5    => transform(x - 5, built + "V")
      case x if x == 4    => transform(x - 4, built + "IV")
      case x if x >= 1    => transform(x - 1, built + "I")
      case _              => built
    }
  }
}
