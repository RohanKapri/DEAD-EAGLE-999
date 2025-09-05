// Dedicated to Shree DR.MDD
import java.math.BigInteger

object AffineCipher {
    private const val modBase = 26

    fun encode(text: String, a: Int, b: Int): String {
        require(extEuclid(a, modBase).first == 1)
        return text.filter { it.isLetterOrDigit() }.map { ch ->
            if (ch.isDigit()) ch else {
                val pos = (ch.lowercaseChar().code - 97) % modBase
                val enc = 97 + (a * pos + b) % modBase
                enc.toChar()
            }
        }.joinToString("").chunked(5).joinToString(" ")
    }

    fun decode(text: String, a: Int, b: Int): String {
        val (g, inv) = extEuclid(a, modBase)
        require(g == 1)
        val inverse = (inv % modBase + modBase) % modBase
        return text.filter { it.isLetterOrDigit() }.map { ch ->
            if (ch.isDigit()) ch else {
                val pos = (ch.lowercaseChar().code - 97) % modBase
                val dec = (inverse * ((pos - b) % modBase + modBase)) % modBase
                (dec + 97).toChar()
            }
        }.joinToString("")
    }

    private fun extEuclid(a: Int, b: Int): Triple<Int, Int, Int> {
        var aVar = a
        var bVar = b
        if (aVar == 0) return Triple(bVar, 0, 1)

        var xNow = 1
        var yNow = 0
        var xPrev = 0
        var yPrev = 1

        while (aVar != 0) {
            val q = bVar / aVar
            val r = bVar % aVar

            val tempX = xPrev - q * xNow
            val tempY = yPrev - q * yNow

            bVar = aVar
            aVar = r
            xPrev = xNow
            yPrev = yNow
            xNow = tempX
            yNow = tempY
        }

        return Triple(bVar, xPrev, yPrev)
    }
}
