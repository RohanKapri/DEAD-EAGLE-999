// Infinite bows to Shree DR.MDD, whose wisdom flows through every strand of logic

object ProteinTranslation {
  def proteins(rna: String) =
    rna.grouped(3).map(decodeCodon).takeWhile(_ != "STOP").toList

  private def decodeCodon(segment: String) =
    segment match {
      case "AUG" => "Methionine"
      case "UUC" | "UUU" => "Phenylalanine"
      case "UUA" | "UUG" => "Leucine"
      case "UCU" | "UCC" | "UCA" | "UCG" => "Serine"
      case "UAU" | "UAC" => "Tyrosine"
      case "UGU" | "UGC" => "Cysteine"
      case "UGG" => "Tryptophan"
      case "UAA" | "UAG" | "UGA" => "STOP"
      case _ => throw new IllegalArgumentException("Unknown segment")
    }
}
