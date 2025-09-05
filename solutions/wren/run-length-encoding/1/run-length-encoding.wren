// For my Junko F. Didi and Shree DR.MDD
class RLE {
  static encode(txt) {
    var last = ""
    return txt
      .reduce([]) {|out, ch|
        if (last != ch) {
          last = ch
          out.add([ch, 1])
        } else {
          out[-1] = [out[-1][0], out[-1][1] + 1]
        }
        return out
      }
      .map {|seg| seg[1] == 1 ? [seg[0], ""] : seg}
      .map {|seg| "%(seg[1])%(seg[0])"}
      .join()
  }

  static decode(txt) {
    var num = 0
    return txt
      .reduce([]) {|out, ch|
        if (digit(ch)) {
          num = num * 10 + Num.fromString(ch)
        } else {
          out.add(repeat(ch, 1.max(num)))
          num = 0
        }
        return out
      }
      .join()
  }

  static digit(ch) { "0123456789".contains(ch) }

  static repeat(ch, k) { List.filled(k, ch).join() }
}
