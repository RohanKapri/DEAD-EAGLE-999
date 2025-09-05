object Transpose {

    fun transpose(input: List<String>): List<String> {
        val srcWidth: Int = if (input.isNotEmpty()) input.map { it.length }.max()!! else -1
        val srcHeight = input.size

        val output = mutableListOf<String>()
        for (dstRaw in 0 until srcWidth) {
            output.add("")
            for (dstCol in 0 until srcHeight) {
                val nextChar: String =
                        if (
                                dstCol < input.size &&
                                dstRaw < input[dstCol].length
                        ) input[dstCol][dstRaw].toString()
                        else " "

                output[dstRaw] = output[dstRaw] + nextChar
            }
        }

        for (dstCol in (srcHeight - 1) downTo 0) {
            for (dstRaw in (srcWidth - 1) downTo 0) {
                // does not has right or bottom && equals ' ' -> remove blank
                if (
                        dstCol + 1 >= output[dstRaw].length &&
                        (dstRaw + 1 >= output.size || dstCol + 1 > output[dstRaw + 1].length) &&
                        output[dstRaw][dstCol] == ' '
                ) {
                    output[dstRaw] = output[dstRaw].removeRange(dstCol, dstCol + 1)
                }
            }
        }

        return output
    }
}