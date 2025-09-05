object ScrabbleScore {
    private val score = "AEIOULNRST".associate { it to 1 }
            .plus("DG".associate { it to 2 })
            .plus("BCMP".associate { it to 3 })
            .plus("FHVWY".associate { it to 4 })
            .plus("K".associate { it to 5 })
            .plus("JX".associate { it to 8 })
            .plus("QZ".associate { it to 10 })

    fun scoreWord(word: String) = word.map { score[it.toUpperCase()]!! }.sum()
}