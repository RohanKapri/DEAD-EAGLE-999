import "random" for Random
class Robot {
  static resetNames() {
    __num = 676000
    __arr = (0...__num).toList
    __rng = Random.new()
  }
  construct new() {reset()}
  reset() {
    if (__num == 0) Fiber.abort("All names consumed")
    __num = __num - 1
    var pos = __rng.int(0, __num)
    var id = __arr[pos]
    __arr[pos] = __arr[__num]
    var A = ["A", 26]
    var N = ["0", 10]
    var res = []
    for (c in [A,A,N,N,N]) {
      var a = c[0]
      var n = c[1]
      var x = id % n
      id = (id / n).floor
      res.add(String.fromCodePoint(a.codePoints[0] + x))
    }
    _name = res.join()
  }
  name {_name}
}
Robot.resetNames()