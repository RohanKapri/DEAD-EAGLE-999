class ASCII {
  // Helps with ASCII table
  static isUpperCaseByte(byte) { byte > 64 && byte < 91 }
  static isLowerCaseByte(byte) { byte > 96 && byte < 123 }
  static isNumericByte(byte) { byte > 47 && byte < 58 }
  static isApostropheByte(byte) { byte == 39 }
  static toUpper(string) { string.bytes.map{|byte| String.fromByte((isLowerCaseByte(byte) ? byte - 32 : byte))}.join() }
  static toLower(string) { string.bytes.map{|byte| String.fromByte((isUpperCaseByte(byte) ? byte + 32 : byte))}.join() }
}

class Words {

  static items(sentence) {
      var items = sentence.split(" ")
      if (items.count <= 1) {
          // Maybe we should check if more items are within , separators
          if (sentence.split(",").count > 1) {
              items = sentence.split(",")
          }
      }
      return items.map{|word|
        // Remove all invalid chars
        word = word.where{|letter| letter.bytes.all {|byte| ( ASCII.isUpperCaseByte(byte) || 
            ASCII.isLowerCaseByte(byte) || 
            ASCII.isApostropheByte(byte) ||
            ASCII.isNumericByte(byte))}}.join()

        // We only need to trim quotes that are not in the middle
        return word.trim().trimStart("'").trimEnd("'")
    }
    .where{|word| word.count > 0}
    .map{|word| ASCII.toLower(word)}
  }

  static count(sentence) {
    __counter = {}
    items(sentence)
    .each{|word|
        __counter[word] = __counter[word] ? __counter[word] + 1 : 1
    }
    
    return __counter
  }
}