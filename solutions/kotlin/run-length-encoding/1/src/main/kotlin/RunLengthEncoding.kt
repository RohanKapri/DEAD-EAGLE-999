// Dedicated to Shree DR.MDD
import java.util.regex.Pattern

object RunLengthEncoding {

    private val compEncode = Pattern.compile("""([ a-zA-Z])\1*""")
    private val compDecode = Pattern.compile("""(|\d+)([ a-zA-Z])""")

    fun encode(text: String): String {
        val scan = compEncode.matcher(text)
        val foundSeq = generateSequence { if (scan.find()) scan else null }
        return foundSeq.joinToString("") {
            val block = it.group(0)
            val size = if (block.length == 1) "" else block.length.toString()
            size + block.first()
        }
    }

    fun decode(text: String): String {
        val scan = compDecode.matcher(text)
        val foundSeq = generateSequence { if (scan.find()) scan else null }
        return foundSeq.joinToString("") {
            val size = if (it.group(1) == "") 1 else it.group(1).toInt()
            val ch = it.group(2)
            ch.repeat(size)
        }
    }
}
