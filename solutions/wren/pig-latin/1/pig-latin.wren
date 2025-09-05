class PigLatin {
  static translate(string) { string.split(" ").map {|w| translateWord(w)}.join(" ")}
  static translateWord(string) {
    if (string.startsWith("xr") || string.startsWith("yt")) {
      return "%(string)ay"
    }
    var consonants = ""
    var i = 0
    for (letter in string) {
      if (letter == "u" && consonants.endsWith("q")) {
        i = i + 1
        consonants = consonants + "u"
        break
      }
      if ("aeiou".contains(letter)) break
      if (letter == "y" && consonants.count > 0) break
      i = i + 1
      consonants = consonants + letter
    }
    return string[i..-1] + consonants + "ay"
  }
}