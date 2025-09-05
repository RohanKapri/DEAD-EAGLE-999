object PigLatin {
    fun translate(input: String) = input
            .split(" ")
            .joinToString(" ") { it.moveConsonantsToEnd() + "ay" }
}

private val consonantSounds = listOf("b", "ch", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "qu", "q", "rh", "r", "squ", "sch", "s", "thr", "th", "t", "v", "w", "x", "y", "z")
private val vowelSounds = listOf("yt", "xr")

private fun String.moveConsonantsToEnd(): String {
    return (consonantSounds.firstOrNull { this.startsWith(it) && vowelSounds.firstOrNull { this.startsWith(it) } == null })?.let { "${removePrefix(it)}$it" } ?: this
}