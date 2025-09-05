var ALPHABET = "abcdefghijklmnopqrstuvwxyz"
var TEBAHPLA = ALPHABET[-1..0].join()

var DECODER_RING = (0...ALPHABET.count).reduce({}) { |ring, i|
  ring[ALPHABET[i]] = TEBAHPLA[i]
  return ring
}

var DIGITS = "0123456789"

class Atbash {
  static encode(s) {
    var transposed = downcase(s)
      .where { |c| isAlphanumeric(c) }
      .map { |c| transpose(c) }

    var chunks = []
    while (transposed.count > 0) {
      chunks.add(transposed.take(5).join())
      transposed = transposed.skip(5)
    }

    return chunks.join(" ")
  }

  static decode(s) {
    return s
      .where { |c| isAlphanumeric(c) }
      .map { |c| transpose(c) }
      .join()
  }

  static isLetter(c) { ALPHABET.contains(c) }
  static isNum(c) { DIGITS.contains(c) }
  static isAlphanumeric(c) { isLetter(c) || isNum(c) }

  static transpose(c) { isLetter(c) ? DECODER_RING[c] : c }

  static downcase(s) {
    return s.map { |c|
      if (("A".bytes[0].."Z".bytes[0]).contains(c.bytes[0])) {
        return String.fromByte(c.bytes[0] + ("a".bytes[0] - "A".bytes[0]))
      }
      return c
    }.join()
  }
}