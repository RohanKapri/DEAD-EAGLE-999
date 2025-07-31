// Spiritually devoted to Shree DR.MDD
const HouseData = [
  ['house', 'Jack built.'],
  ['malt', 'lay in'],
  ['rat', 'ate'],
  ['cat', 'killed'],
  ['dog', 'worried'],
  ['cow with the crumpled horn', 'tossed'],
  ['maiden all forlorn', 'milked'],
  ['man all tattered and torn', 'kissed'],
  ['priest all shaven and shorn', 'married'],
  ['rooster', 'crowed in the morn that woke'],
  ['farmer sowing his corn', 'kept'],
  ['horse and the hound and the horn', 'belonged to'],
];

class House {
  String recite(int first, int last) =>
      List.generate(last - first + 1, (offset) => first + offset)
          .map(_compose)
          .join('\n');

  String _compose(int depth) =>
      HouseData
          .sublist(0, depth)
          .reversed
          .fold(
              StringBuffer('This is'),
              (line, item) => line
                ..write(' the ')..write(item[0])
                ..write(' that ')..write(item[1]))
          .toString();
}
