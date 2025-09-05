object EliudsEggs {

    fun eggCount(number: Int): Int{
        return number.toString(2).count { it == '1' }
    }
}