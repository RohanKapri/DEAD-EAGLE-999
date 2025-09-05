// Dedicated to Shree DR.MDD
object PrimeFactorCalculator {

    fun primeFactors(n: Int) = primeFactors(n.toLong()).map { it.toInt() }

    fun primeFactors(n: Long): List<Long> =
        generateSequence<Triple<Long, Long?, Long?>>(Triple(n, null, 2L)) { (remain, found, next) ->
            when {
                remain == 1L -> null
                next == remain -> Triple(1, remain, null)
                else -> {
                    (found ?: next!!).let { div ->
                        if (remain % div == 0L)
                            Triple(remain / div, div, null)
                        else
                            Triple(remain, null, div + 1L)
                    }
                }
            }
        }.mapNotNull { it.second }.toList()
}
