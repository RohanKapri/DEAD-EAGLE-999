object House {

  case class Form(actor: String, action: String) {
    override def toString(): String = s"the $actor that $action"
  }

  val forms: Map[Int, Form] = Map(
    1 -> Form("house", "Jack built"),
    2 -> Form("malt", "lay in"),
    3 -> Form("rat", "ate"),
    4 -> Form("cat", "killed"),
    5 -> Form("dog", "worried"),
    6 -> Form("cow with the crumpled horn", "tossed"),
    7 -> Form("maiden all forlorn", "milked"),
    8 -> Form("man all tattered and torn", "kissed"),
    9 -> Form("priest all shaven and shorn", "married"),
    10 -> Form("rooster that crowed in the morn", "woke"),
    11 -> Form("farmer sowing his corn", "kept"),
    12 -> Form("horse and the hound and the horn", "belonged to")
  )

  def recite(start: Int, end: Int): String = (start to end map verse mkString "\n") + "\n\n"

  def verse(i: Int): String = {
    val content = (i to 1 by -1) map { k => forms(k).toString } mkString " "
    s"This is $content."
  }
}