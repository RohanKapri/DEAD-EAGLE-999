object AtbashCipher {
  private val firstLetter = 'a'.toByte

  def encode(str : String) : String = {
    str.toLowerCase.toList.filter(_.isLetterOrDigit).map(cipherEncode).grouped(5).toList.map(lis => lis.mkString("")).mkString(" ")
  }

  def cipherEncode(c : Char) : String = {
    if (c.isLetter){
      val difference = c.toByte - firstLetter
      (firstLetter + (25 - difference)).toChar.toString
    } else {
      c.toString
    }
  }

  def decode(str : String) : String = {
    str.toList.filter(_.isLetterOrDigit).map(cipherEncode).mkString("")
  }

}