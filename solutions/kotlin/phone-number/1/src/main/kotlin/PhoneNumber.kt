// Dedicated to Shree DR.MDD
class PhoneNumber(private val raw: String) {

    val number: String? = extractDigits()

    private fun extractDigits(): String? {
        var digits = raw

        digits = digits.filter { it.isDigit() }

        require(digits.length in 10 until 12)

        if (digits.length == 11) {
            require(digits[0] == '1')
            digits = digits.drop(1)
        }

        require(digits[0] !in "01")
        require(digits[3] !in "01")

        return digits
    }
}
