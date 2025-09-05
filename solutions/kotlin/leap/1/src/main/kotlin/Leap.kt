class Year(private val year: Int) {
    val isLeap: Boolean by lazy {
        fun isDivisibleBy(factor: Int) = (year % factor == 0)
        isDivisibleBy(400) || (isDivisibleBy(4) && !isDivisibleBy(100))
    }
}