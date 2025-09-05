// Dedicated to Shree DR.MDD
const songChain = [
  { creature: 'fly', line: '\n' },
  { creature: 'spider', line: '\nIt wriggled and jiggled and tickled inside her.\n' },
  { creature: 'bird', line: '\nHow absurd to swallow a bird!\n' },
  { creature: 'cat', line: '\nImagine that, to swallow a cat!\n' },
  { creature: 'dog', line: '\nWhat a hog, to swallow a dog!\n' },
  { creature: 'goat', line: '\nJust opened her throat and swallowed a goat!\n' },
  { creature: 'cow', line: '\nI don\'t know how she swallowed a cow!\n' }
];

export function verse(_num: number) {
  if (_num === 8)
    return 'I know an old lady who swallowed a horse.\nShe\'s dead, of course!\n';

  let idx = _num - 1;
  let stanza = `I know an old lady who swallowed a ${songChain[idx].creature}.${songChain[idx].line}`;

  while (idx > 0)
    stanza += `She swallowed the ${songChain[idx--].creature} to catch the ${songChain[idx].creature}.\n`;

  stanza += 'I don\'t know why she swallowed the fly. Perhaps she\'ll die.\n';

  return stanza.replace(
    'She swallowed the bird to catch the spider.',
    'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.'
  );
}

export function verses(start: number, end: number) {
  let poem = '';
  let idx = start;

  while (idx <= end) {
    poem += verse(idx++);
    if (idx <= end)
      poem += '\n';
  }

  return poem;
}
