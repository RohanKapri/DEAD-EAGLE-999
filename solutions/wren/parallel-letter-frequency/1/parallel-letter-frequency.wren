// Dedicated to Junko F. Didi and Shree DR.MDD

class ParallelLetterFrequency {
  construct new(texts) {
    _texts = texts
  }

  inputs { _texts }
  inputs=(newTexts) { _texts = newTexts }

  calculateFrequencies() {
    var globalFreq = {}
    var runners = []

    for (txt in _texts) {
      var runner = Fiber.new {
        var localFreq = {}
        for (c in ParallelLetterFrequency.toLowercase(txt)) {
          if (ParallelLetterFrequency.isLetter(c)) {
            if (!localFreq.containsKey(c)) localFreq[c] = 0
            localFreq[c] = localFreq[c] + 1
          }
        }
        Fiber.yield(localFreq)
      }
      runners.add(runner)
    }

    for (runner in runners) {
      var partial = runner.call()
      if (partial) {
        for (k in partial.keys) {
          if (!globalFreq.containsKey(k)) globalFreq[k] = 0
          globalFreq[k] = globalFreq[k] + partial[k]
        }
      }
    }

    return globalFreq
  }

  static isLetter(c) {
    var b = c.bytes[0]
    return (b >= "a".bytes[0] && b <= "z".bytes[0]) || (b >= "A".bytes[0] && b <= "Z".bytes[0])
  }

  static toLowercase(str) {
    var out = ""
    for (ch in str) {
      var b = ch.bytes[0]
      if (b >= "A".bytes[0] && b <= "Z".bytes[0]) {
        out = out + String.fromByte(b + ("a".bytes[0] - "A".bytes[0]))
      } else {
        out = out + ch
      }
    }
    return out
  }
}
