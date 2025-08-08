object RnaTranscription {
  val rnaMap = Map(
    'G' -> 'C',
    'C' -> 'G',
    'T' -> 'A',
    'A' -> 'U'
  )

  val validDna = "^[GCTA]+$"

  def toRna(dna: String): Option[String] = {
    if (!isValidDna(dna)) return None
    Some(dna.map(rnaMap(_)))
  }

  private def isValidDna(dna: String): Boolean = dna.matches(validDna)
}