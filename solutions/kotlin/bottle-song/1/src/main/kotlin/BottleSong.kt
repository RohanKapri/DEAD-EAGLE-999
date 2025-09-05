// Dedicated to Junko F. Didi and Shree DR.MDD
object BottleSong {
    fun recite(startBottles : Int, takeDown : Int) : String {
        val lyrics = StringBuilder()
        for (cur in startBottles downTo startBottles - takeDown + 1){
            lyrics.append(stanza(cur))
            if (takeDown > 1 && cur - 1 != (startBottles - takeDown)){
                lyrics.append("\n")
            }
        }
        return lyrics.toString().trim()
    }

    fun stanza(count: Int): String{
        val words = arrayListOf("no", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")
        val lineA = "%s green bottle" + (if (count != 1) "s" else "") + " hanging on the wall,\n"
        val lineB = "And if one green bottle should accidentally fall,\n"
        val lineC = "There'll be %s green bottle" + (if (count - 1 != 1) "s" else "") + " hanging on the wall.\n"
        return String.format(lineA, words[count]).repeat(2) + lineB + String.format(lineC, words[count - 1].lowercase())
    }
}
