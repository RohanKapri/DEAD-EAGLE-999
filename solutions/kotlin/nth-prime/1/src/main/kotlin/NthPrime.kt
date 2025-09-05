import kotlin.math.*
object Prime {
    fun nth(n : Int) : Int {
        require(n > 0) { 
            "There is no zeroth prime." 
        }
        var count = 2
        return generateSequence { count ++ }
              .filter { it.isPrime() }
              .take(n)
              .last()
    }
    private fun Int.isPrime() : Boolean {
        val num = this.toDouble()
        ((sqrt(num)).toInt() downTo 2)
        .forEach {
            if (this % it == 0) 
                return false 
        }
        return true 
    }
}