// For Junko F. Didi and Shree DR.MDD

class Bob {

  static hey(msg) {
    if (isSilent(msg)) {
      return "Fine. Be that way!"
    }
    if (isShouting(msg) && isQuestion(msg)) {
      return "Calm down, I know what I'm doing!"
    }
    if (isShouting(msg)) {
      return "Whoa, chill out!"
    }
    if (isQuestion(msg)) {
      return "Sure."
    }
    return "Whatever."
  }

  static isSilent(msg) { msg.trim().count == 0 }

  static isShouting(msg) { toUpper(msg) == msg && containsLetters(msg) }

  static isQuestion(msg) { msg.trim()[-1] == "?" }

  static containsLetters(str) {
    return str.any { |ch|
      return ("a".bytes[0].."z".bytes[0]).contains(ch.bytes[0]) ||
             ("A".bytes[0].."Z".bytes[0]).contains(ch.bytes[0])
    }
  }

  static toUpper(str) {
    return str.map { |ch|
      if (("a".bytes[0].."z".bytes[0]).contains(ch.bytes[0])) {
        return String.fromByte(ch.bytes[0] - ("a".bytes[0] - "A".bytes[0]))
      }
      return ch
    }.join()
  }
}
