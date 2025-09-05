export function isPangram(sentence: string): boolean {
  sentence = sentence.replace(/[0-9]/g, '');
  const letterArray = sentence.toLowerCase().split('');
  let letterSet = new Set(letterArray);
  letterSet.delete(' ');
  letterSet.delete('_');
  letterSet.delete('.');
  letterSet.delete('"');
  return letterSet.size == 26;
}
 