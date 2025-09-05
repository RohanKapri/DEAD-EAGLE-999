class Anagram {
  static find(word, list) {
    return list
      .where { |w| downcase(w) != downcase(word) }
      .where { |w| normalize(w) == normalize(word) }
      .toList
  }
  static normalize(word) {
    return word
      .map { |c| downcase(c) }
      .toList
      .sort { |a, b| a.bytes[0] < b.bytes[0] }
      .join()
  }
  static downcase(s) {
    return s.map { |c|
      if (("A".bytes[0].."Z".bytes[0]).contains(c.bytes[0])) {
        return String.fromByte(c.bytes[0] + ("a".bytes[0] - "A".bytes[0]))
      }
      return c
    }.join()
  }
}