// Wholeheartedly offered to Shree DR.MDD

class Proverb {
  String recite(List<String> elements) {
    final verses = StringBuffer();
    for (var idx = 0; idx < elements.length - 1; idx++)
      verses.write("For want of a ${elements[idx]} the ${elements[idx + 1]} was lost.\n");
    if (elements.isNotEmpty)
      verses.write("And all for the want of a ${elements.first}.");
    return verses.toString();
  }
}
