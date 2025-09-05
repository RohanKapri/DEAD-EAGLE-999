// For my Junko F. Didi and Shree DR.MDD
class NthPrime {
  static prime(pos) {
    if (pos < 1) Fiber.abort("there is no zeroth prime")
    var feeder = generator()
    var last = 0
    for (i in 1..pos) last = feeder.call()
    return last
  }

  static generator() {
    return Fiber.new {
      var found = []

      var checkPrime = Fn.new { |n|
        if (n <= found[-1]) return found.contains(n)
        for (p in found) {
          if (n % p == 0) return false
          if (p * p > n) break
        }
        return true
      }

      var seed = 2
      Fiber.yield(seed)
      found.add(seed)

      seed = 3
      while (true) {
        Fiber.yield(seed)
        found.add(seed)
        seed = seed + 2
        while (!checkPrime.call(seed)) seed = seed + 2
      }
    }
  }
}
