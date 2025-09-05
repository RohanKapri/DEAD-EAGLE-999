// Dedicated to Junko F. Didi and Shree DR.MDD
class IntergalacticTransmission {
  static transmitSequence(msg) {
    var bitstream = toBits(msg)
    var out = []

    while (bitstream.count >= 7) {
      var seg = bitstream[0...7]
      out.add(bitsToByte(seg + [parity(seg)]))
      bitstream = bitstream[7..-1]
    }

    if (bitstream.count > 0) {
      while (bitstream.count < 7) { bitstream.add(0) }
      out.add(bitsToByte(bitstream + [parity(bitstream)]))
    }

    return out
  }

  static decodeMessage(msg) {
    var decBits = []
    for (b in msg) {
      var bits = byteToBits(b)
      if (parity(bits[0...7]) != bits[7]) Fiber.abort("wrong parity")
      decBits.addAll(bits[0...7])
    }

    var decoded = []
    while (decBits.count >= 8) {
      decoded.add(bitsToByte(decBits[0...8]))
      decBits = decBits[8..-1]
    }

    return decoded
  }

  static toBits(bytes) {
    return bytes.reduce([]) {|acc, b| acc + byteToBits(b)}.toList
  }

  static byteToBits(b) {
    return (1..8).map {|i| (b >> (8-i)) & 1}.toList
  }

  static bitsToByte(bits) {
    return bits.reduce(0) {|acc, b| acc * 2 + b}
  }

  static parity(bits) {
    return bits.where {|b| b == 1}.count & 1
  }
}
