object MatchingBrackets {

    val brackets = "[]{}()".toSet()

    fun matchAway(input : String) = 
        input.replace("[]", "")
             .replace("{}", "")
             .replace("()", "")

    fun isValid(input : String) : Boolean {
        tailrec 
        fun pairOff(remn : String) : Boolean {
            if (remn.isEmpty())
                return true
            val upd = matchAway(remn) 
            return if (upd.length == remn.length) 
                       false 
                   else 
                       pairOff(upd)
        }
        return pairOff(input.filter { it in brackets })
    }
}