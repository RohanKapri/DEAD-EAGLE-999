object PigLatin {
    def pigIt(t: String): Int = t.toSeq match {
        case Seq('a' | 'e' | 'i' | 'o' | 'u', _*) => 0
        case Seq('q', 'u', _*) => 2
        case Seq('c' | 'r', 'h', _*) => 2
        case Seq('t', 'h', 'r', _*) => 3
        case Seq('t', 'h', _*) => 2
        case Seq('x', 'r', _*) => 0
        case Seq('y', 't', _*) => 0
        case Seq('s', 'c', 'h', _*) => 3
        case Seq('s', 'q', 'u', _*) => 3
        case _ => 1
    }

    def translate(txt: String): String = txt.split(" ").map { t =>
        ((n: Int) => t.drop(n) + t.take(n) + "ay")(pigIt(t))}.mkString(" ")
}