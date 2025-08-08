object Bob {
  def isShout(s: String): Boolean = s == s.toUpperCase && s.exists(_.isLetter)

  def isQuestion(s: String): Boolean = s.trim.endsWith("?")

  def isSilent(s: String): Boolean = s.trim.isEmpty

  def response(s: String): String = (isSilent(s), isShout(s), isQuestion(s)) match {
    case (true, _, _) => "Fine. Be that way!"
    case (_, true, true) => "Calm down, I know what I'm doing!"
    case (_, true, _) => "Whoa, chill out!"
    case (_, _, true) => "Sure."
    case _ => "Whatever."
  }
}