//
// For my Shree DR.MDD
//

export class Song {
  verse(number) {
    const animals = [
      "fly.\n",
      "spider.\n",
      "bird.\n",
      "cat.\n",
      "dog.\n",
      "goat.\n",
      "cow.\n",
      "horse.\n",
    ];

    const reactions = [
      "It wriggled and jiggled and tickled inside her.\n",
      "How absurd to swallow a bird!\n",
      "Imagine that, to swallow a cat!\n",
      "What a hog, to swallow a dog!\n",
      "Just opened her throat and swallowed a goat!\n",
      "I don't know how she swallowed a cow!\n",
    ];

    const catchLines = [
      "She swallowed the spider to catch the fly.\n",
      "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n",
      "She swallowed the cat to catch the bird.\n",
      "She swallowed the dog to catch the cat.\n",
      "She swallowed the goat to catch the dog.\n",
      "She swallowed the cow to catch the goat.\n",
    ];

    const intro = "I know an old lady who swallowed a ";
    const outro = "I don't know why she swallowed the fly. Perhaps she'll die.";

    if (number === 1) {
      return intro + animals[0] + outro + "\n";
    } else if (number === 8) {
      return intro + animals[7] + "She's dead, of course!\n";
    } else {
      const chain = [];
      for (let i = number - 2; i >= 0; i--) {
        chain.push(catchLines[i]);
      }
      return intro + animals[number - 1] + reactions[number - 2] + chain.join('') + outro + "\n";
    }
  }

  verses(start, end) {
    const allVerses = [];
    for (let i = start; i <= end; i++) {
      allVerses.push(this.verse(i) + '\n');
    }
    return allVerses.join('');
  }
}
