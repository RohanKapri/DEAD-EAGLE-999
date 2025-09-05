class Acronym {
  static parse(phrase) {phrase.replace("-", " ")
    .replace("_", "")
    .replace(".", "")
    .replace("'", "")
    .split(" ")
    .where {|item| item.trim().count > 0}
    .map {|item| item[0]}
    .map{|letter|
      return letter.bytes.map{|byte|
        if (byte > 96 && byte < 123) {
          byte = byte - 32
        }
        return String.fromByte(byte)
      }.join()
    }.join()}
}