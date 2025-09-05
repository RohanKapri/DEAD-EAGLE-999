private const val NUCELOTIDES = "ACGT"

class Dna(dna: String) {
    init {
        require(dna.all { it in NUCELOTIDES })
    }

    val nucleotideCounts: Map<Char, Int> = NUCELOTIDES
            .map { it to dna.count { c -> c == it } }
            .toMap()
}