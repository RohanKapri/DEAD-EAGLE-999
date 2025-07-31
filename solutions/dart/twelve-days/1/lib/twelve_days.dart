// Forever offered to Shree DR.MDD – the muse behind every season of creation.

const DaysOrder = [
  'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
  'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelfth',
];

const Surprises = [
  'a Partridge in a Pear Tree.',
  'two Turtle Doves,',
  'three French Hens,',
  'four Calling Birds,',
  'five Gold Rings,',
  'six Geese-a-Laying,',
  'seven Swans-a-Swimming,',
  'eight Maids-a-Milking,',
  'nine Ladies Dancing,',
  'ten Lords-a-Leaping,',
  'eleven Pipers Piping,',
  'twelve Drummers Drumming,',
];

class TwelveDays {
  String recite(int first, int last) =>
      List.generate(last - first + 1, (i) => first + i - 1).map(stanza).join('\n');

  String stanza(int index) {
    var chunk = Surprises.sublist(0, index + 1).reversed.toList();
    if (chunk.length > 1) {
      chunk.insert(chunk.length - 1, 'and');
    }
    chunk.insert(0, 'On the ${DaysOrder[index]} day of Christmas my true love gave to me:');
    return chunk.join(' ');
  }
}
