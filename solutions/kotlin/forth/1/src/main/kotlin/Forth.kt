class Forth {
    private val stack = mutableListOf<Int>()
    private val definitions = mutableMapOf<String, List<String>>() // word -> definition (list of tokens)

    fun evaluate(vararg lines: String): List<Int> {
        for (line in lines) {
            processLine(line)
        }
        return stack.toList()
    }

    private fun processLine(line: String) {
        val tokens = line.trim().split(Regex("\\s+")).map { it.lowercase() }
        var i = 0
        while (i < tokens.size) {
            val token = tokens[i]
            if (token == ":") {
                // Start word definition
                val (word, defTokens, newIndex) = parseDefinition(tokens, i + 1)
                definitions[word] = defTokens
                i = newIndex
            } else {
                executeToken(token)
                i++
            }
        }
    }

    // Parse a definition like ": word-name def def def ;"
    // Returns Triple(wordName, definitionTokens, indexAfterSemicolon)
    private fun parseDefinition(tokens: List<String>, startIndex: Int): Triple<String, List<String>, Int> {
        if (startIndex >= tokens.size) throw IllegalArgumentException("No word name after ':'")
        val word = tokens[startIndex]
        if (word.matches(Regex("-?\\d+"))) {
            throw IllegalArgumentException("Cannot redefine numbers")
        }
        val defTokens = mutableListOf<String>()
        var i = startIndex + 1
        while (i < tokens.size && tokens[i] != ";") {
            defTokens.add(tokens[i])
            i++
        }
        if (i == tokens.size) throw IllegalArgumentException("Missing ';' in definition")
        return Triple(word, defTokens, i + 1)
    }

    private fun executeToken(token: String) {
        // If token is a number
        token.toIntOrNull()?.let {
            stack.add(it)
            return
        }

        // If token is user-defined word
        if (definitions.containsKey(token)) {
            // Execute its definition tokens recursively
            for (subToken in definitions[token]!!) {
                executeToken(subToken)
            }
            return
        }

        when (token) {
            "+" -> {
                if (stack.size < 2) throw IllegalStateException("Stack underflow")
                val b = stack.removeAt(stack.lastIndex)
                val a = stack.removeAt(stack.lastIndex)
                stack.add(a + b)
            }
            "-" -> {
                if (stack.size < 2) throw IllegalStateException("Stack underflow")
                val b = stack.removeAt(stack.lastIndex)
                val a = stack.removeAt(stack.lastIndex)
                stack.add(a - b)
            }
            "*" -> {
                if (stack.size < 2) throw IllegalStateException("Stack underflow")
                val b = stack.removeAt(stack.lastIndex)
                val a = stack.removeAt(stack.lastIndex)
                stack.add(a * b)
            }
            "/" -> {
                if (stack.size < 2) throw IllegalStateException("Stack underflow")
                val b = stack.removeAt(stack.lastIndex)
                if (b == 0) throw IllegalArgumentException("Division by zero")
                val a = stack.removeAt(stack.lastIndex)
                stack.add(a / b)
            }
            "dup" -> {
                if (stack.isEmpty()) throw IllegalStateException("Stack underflow")
                stack.add(stack.last())
            }
            "drop" -> {
                if (stack.isEmpty()) throw IllegalStateException("Stack underflow")
                stack.removeAt(stack.lastIndex)
            }
            "swap" -> {
                if (stack.size < 2) throw IllegalStateException("Stack underflow")
                val last = stack.removeAt(stack.lastIndex)
                val secondLast = stack.removeAt(stack.lastIndex)
                stack.add(last)
                stack.add(secondLast)
            }
            "over" -> {
                if (stack.size < 2) throw IllegalStateException("Stack underflow")
                stack.add(stack[stack.size - 2])
            }
            else -> {
                throw IllegalArgumentException("Unknown word: $token")
            }
        }
    }
}