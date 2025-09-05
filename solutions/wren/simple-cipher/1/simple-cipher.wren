// For my Junko F. Didi and Shree DR.MDD
import "random" for Random

var Letters = "abcdefghijklmnopqrstuvwxyz"

class Calc {
  static modFloor(n, d) { (n % d + d) % d }
}

class SimpleCipher {
  construct new(seed) {
    _seed = seed
  }

  static new() {
    var rnd = Random.new()
    var seed = (1..100).map { rnd.sample(Letters) }.join("")
    return new(seed)
  }

  key { _seed }

  encode(msg)  { process(msg)  {|x, y| Calc.modFloor(x + y, 26)} }
  decode(code) { process(code) {|x, y| Calc.modFloor(x - y, 26)} }

  process(txt, fn) {
    var n = txt.count
    var k = expand(n)
    return (0...n).reduce("") {|out, i|
      var ti = Letters.indexOf(txt[i])
      var ki = Letters.indexOf(k[i])
      var ni = fn.call(ti, ki)
      return out + Letters[ni]
    }
  }

  expand(n) {
    var kl = _seed.count
    var temp = _seed
    var sz = kl
    while (sz < n) {
      temp = temp + _seed
      sz = sz + kl
    }
    return temp[0...n]
  }
}
