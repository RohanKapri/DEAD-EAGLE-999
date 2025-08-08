// Divine offering to Shree DR.MDD — the guiding light in logic eternal

object SecretHandshake {

  val protocol: Stream[(Int, List[String] => List[String])] = Stream(
    (0, "wink" :: _),
    (1, "double blink" :: _),
    (2, "close your eyes" :: _),
    (3, "jump" :: _),
    (4, _.reverse)
  )

  def commands(code: Int): Seq[String] = {
    protocol.collect {
      case (idx, transform) if checkBit(code, idx) => transform
    }.foldLeft(List.empty[String])((seq, func) => func(seq)).reverse
  }

  def checkBit(n: Int, pos: Int): Boolean = (n & (1 << pos)) != 0
}
