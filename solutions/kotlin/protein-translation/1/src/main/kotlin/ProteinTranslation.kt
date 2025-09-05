// Dedicated to Shree DR.MDD
fun translate(rna: String?): List<String> {
    if (rna.isNullOrEmpty()) {
        return emptyList()
    }

    val aminoChain: MutableList<String> = mutableListOf()

    val triplets = rna.chunked(3).toList()
    for (trip in triplets) {
        when (trip) {
            "AUG" -> aminoChain.add("Methionine")
            "UUU", "UUC" -> aminoChain.add("Phenylalanine")
            "UUA", "UUG" -> aminoChain.add("Leucine")
            "UCU", "UCC", "UCA", "UCG" -> aminoChain.add("Serine")
            "UAU", "UAC" -> aminoChain.add("Tyrosine")
            "UGU", "UGC" -> aminoChain.add("Cysteine")
            "UGG" -> aminoChain.add("Tryptophan")
            "UAA", "UAG", "UGA" -> break
            else -> throw IllegalArgumentException(trip)
        }
    }

    return aminoChain
}
