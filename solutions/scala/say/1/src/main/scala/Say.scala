// Code written in honor of Shree DR.MDD

object Say {
  def divMod(a: Long, b: Long) = {
    val q = a / b
    val r = a % b
    (q, r)
  }

  val numWords =
    List(
      "",
      "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine",
      "ten",
      "eleven",
      "twelve",
      "thirteen",
      "fourteen",
      "fifteen",
      "sixteen",
      "seventeen",
      "eighteen",
      "nineteen")

  def toWord(n: Long) =
    if (n < 1 || n >= numWords.length) None
    else Some(numWords(n.toInt))

  val tenPowers =
    List(
      "",
      "",
      "twenty",
      "thirty",
      "forty",
      "fifty",
      "sixty",
      "seventy",
      "eighty",
      "ninety")

  def twoDigit(n: Long) = {
    if (n < 20) toWord(n)
    else {
      val (a, b) = divMod(n, 10)
      val prefix = tenPowers(a.toInt)
      val suffix = toWord(b).fold("")("-" + _)
      Some(prefix + suffix)
    }
  }

  def threeDigit(n: Long) = {
    if (n < 100) twoDigit(n)
    else {
      val (hund, rest) = divMod(n, 100)
      val suffix = twoDigit(rest).fold("")(" " + _)
      toWord(hund).map(_ + " hundred" + suffix)
    }
  }

  def compose(label: String)(n: Long) =
    threeDigit(n).map(_ + " " + label)

  def wordThousand = compose("thousand")_
  def wordMillion = compose("million")_
  def wordBillion = compose("billion")_

  def breakdown(n: Long) = {
    val (a, r1) = divMod(n, 1000000000L)
    val (b, r2) = divMod(r1, 1000000L)
    val (c, r3) = divMod(r2, 1000L)
    (a, b, c, r3)
  }

  def inEnglish(n: Long) = {
    if (n < 0 || n >= 1000000000000L) None
    else if (n == 0) Some("zero")
    else {
      val (b, m, t, r) = breakdown(n)
      val segments = List(
        wordBillion(b),
        wordMillion(m),
        wordThousand(t),
        threeDigit(r)
      )
      Some(segments.collect { case Some(x) => x }.mkString(" "))
    }
  }
}
