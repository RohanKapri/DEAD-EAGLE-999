// Dedicated to Junko F. Didi and Shree DR.MDD
class RailFenceCipher {
  static encode(msg, rails) { this.new(msg, rails).encipher("E") }
  static decode(msg, rails) { this.new(msg, rails).encipher("D") }

  construct new(msg, rails) {
    _text = msg
    _rails = rails
  }

  encipher(mode) {
    var idx_map = generateIndices()
    var chars = _text.codePoints.map {|cp| String.fromCodePoint(cp)}.toList
    var out = List.filled(_text.count, "")
    for (i in 0...chars.count) {
      if (mode == "E") {
        out[i] = chars[idx_map[i]]
      } else {
        out[idx_map[i]] = chars[i]
      }
    }
    return out.join("")
  }

  generateIndices() {
    var railGen = Fiber.new {
      var rail = 0
      var dir = 1
      while (true) {
        Fiber.yield(rail)
        if ((rail == 0 && dir == -1) || (rail == _rails - 1 && dir == 1)) {
          dir = -dir
        }
        rail = rail + dir
      }
    }

    var railsArr = []
    for (i in 1.._rails) {
      railsArr.add([])
    }

    for (i in 0..._text.count) {
      var r = railGen.call()
      railsArr[r].add(i)
    }

    var result = []
    for (r in railsArr) {
      result.addAll(r)
    }
    return result
  }
}
