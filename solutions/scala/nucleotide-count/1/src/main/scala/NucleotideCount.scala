class DNA(s: String) {
  val validBases = "ACTG"

  val zeroCounts = Map('A' -> 0, 'C' -> 0, 'G' -> 0, 'T' -> 0)

  val nucleotideCounts: Either[Exception, Map[Char, Int]] = {
    val grouped = s groupBy identity
    if (grouped.keysIterator forall { c => validBases.contains(c) })
      Right(zeroCounts ++ (grouped mapValues {_.length}))
    else
      Left(new Exception("invalid bases in DNA string"))
  }
}