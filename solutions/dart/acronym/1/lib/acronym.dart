
final wordRegex = RegExp(r"(\p{Alpha})[\w']*", unicode: true);

class Acronym {
  String abbreviate(String input) =>
      wordRegex.allMatches(input).map((m) => m.group(1)).join('').toUpperCase();
}