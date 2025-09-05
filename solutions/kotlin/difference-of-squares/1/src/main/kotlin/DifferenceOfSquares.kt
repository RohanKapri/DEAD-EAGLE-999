class Squares(private val numberOfSquares: Int) {
    fun sumOfSquares(): Int = (1..numberOfSquares).map { s -> s * s }.sum()

    fun squareOfSum(): Int {
        val sum = (1..numberOfSquares).sum()
        return sum * sum
    }

    fun difference(): Int = squareOfSum() - sumOfSquares()
}