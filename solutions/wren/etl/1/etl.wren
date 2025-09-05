class Etl {
  static transform(legacy) {
    var newFormat = {}
    for (score in legacy.keys) {
      var letters = legacy[score]
      for (letter in letters) {
        newFormat[toLower(letter)] = score
      }
    }
    return newFormat
  }
  static toLower(letter) {
    var byte = letter.bytes[0]
    
    if (byte >= 65 && byte <= 90) {
      byte = byte + 32
    }
    return String.fromByte(byte)
  }
}