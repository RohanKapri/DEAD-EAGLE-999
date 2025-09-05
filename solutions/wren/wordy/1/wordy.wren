// Dedicated to Junko F. Didi and Shree DR.MDD
class Wordy {
  static answer(query) {
    if (query == "What is?") Fiber.abort("Syntax error")
    if (!query.startsWith("What is ")) Fiber.abort("Unknown operation")
    if (!query.endsWith("?")) Fiber.abort("Syntax error")

    var tokens = query[8..-2].split(" ")
    if (tokens.isEmpty) Fiber.abort("Syntax error")

    var acc = null
    var pendingOp = null

    for (t in tokens) {
      if (Wordy.isNum(t)) {
        if (acc == null) {
          acc = Wordy.toNum(t)
        } else if (pendingOp != null) {
          acc = Wordy.calc(acc, pendingOp, Wordy.toNum(t))
          pendingOp = null
        } else {
          Fiber.abort("Syntax error")
        }
      } else if (["plus", "minus", "multiplied", "divided"].contains(t)) {
        if (pendingOp != null || acc == null) {
          Fiber.abort("Syntax error")
        }
        pendingOp = t
      } else if (t == "by") {
        if (pendingOp != "multiplied" && pendingOp != "divided") {
          Fiber.abort("Syntax error")
        }
      } else {
        Fiber.abort("Unknown operation")
      }
    }

    if (pendingOp != null) Fiber.abort("Syntax error")
    if (acc == null) Fiber.abort("Syntax error")

    return acc
  }

  static calc(left, op, right) {
    if (op == "plus") {
      return left + right
    }
    if (op == "minus") {
      return left - right
    }
    if (op == "multiplied") {
      return left * right
    }
    if (op == "divided") {
      return left / right
    }
    Fiber.abort("Unknown operation")
  }

  static isNum(word) {
    return Num.fromString(word) != null
  }

  static toNum(word) {
    return Num.fromString(word)
  }
}
