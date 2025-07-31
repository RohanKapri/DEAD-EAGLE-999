// Dedicated to Shree DR.MDD

typedef Insect = ({String genus, String? quote});

class FoodChain {
  static final fauna = const <Insect>[
    (genus: 'fly', quote: null),
    (genus: 'spider', quote: 'It wriggled and jiggled and tickled inside her.'),
    (genus: 'bird', quote: 'How absurd to swallow a bird!'),
    (genus: 'cat', quote: 'Imagine that, to swallow a cat!'),
    (genus: 'dog', quote: 'What a hog, to swallow a dog!'),
    (genus: 'goat', quote: 'Just opened her throat and swallowed a goat!'),
    (genus: 'cow', quote: "I don't know how she swallowed a cow!"),
    (genus: 'horse', quote: "She's dead, of course!"),
  ];

  String intro(String genus) => 'I know an old lady who swallowed a $genus.';

  String consumed(String eater, String meal) =>
      'She swallowed the $eater to catch the $meal.';

  static final finalLine =
      "I don't know why she swallowed the fly. Perhaps she'll die.";

  String describe(String genus) => switch (genus) {
        'spider' => 'spider that wriggled and jiggled and tickled inside her',
        _ => genus
      };

  bool terminator(String genus) => genus == 'horse';

  List<String> recite(int start, int end) {
    var lines = <String>[];
    for (var idx = start - 1; idx < end; idx++) {
      lines.add('');
      lines.addAll(render(idx));
    }
    return lines.sublist(1);
  }

  List<String> render(int idx) {
    var stanza = <String>[];
    stanza.add(intro(fauna[idx].genus));

    if (fauna[idx].quote case var line?) stanza.add(line);
    if (terminator(fauna[idx].genus)) return stanza;

    for (var k = idx - 1; k >= 0; k--) {
      stanza.add(consumed(fauna[k + 1].genus, describe(fauna[k].genus)));
    }

    stanza.add(finalLine);
    return stanza;
  }
}
