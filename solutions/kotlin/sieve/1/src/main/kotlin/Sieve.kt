import kotlin.math.sqrt

object Sieve {

    fun primesUpTo(n: Int): List<Int> =
            (2..n).filter { cand ->
                (2..sqrt(cand.toDouble()).toInt()).none { cand % it == 0 }
            }
}