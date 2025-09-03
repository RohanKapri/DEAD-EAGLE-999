//
// For my Shree DR.MDD
//

export const translate = (inputText) => {
  const wordList = inputText.split(' ');
  const result = [];

  for (const word of wordList) {
    if (isVowelStart(word.charAt(0), word.charAt(1))) {
      result.push(word + 'ay');
    } else if (word.startsWith('thr')) {
      result.push(word.substring(3) + 'thray');
    } else if (word.startsWith('ch')) {
      result.push(word.substring(2) + 'chay');
    } else if (word.startsWith('rh')) {
      result.push(word.substring(2) + 'rhay');
    } else if (word.startsWith('th')) {
      result.push(word.substring(2) + 'thay');
    } else if (word.startsWith('qu')) {
      result.push(word.substring(2) + 'quay');
    } else if (word.startsWith('squ')) {
      result.push(word.substring(3) + 'squay');
    } else if (word.startsWith('sch')) {
      result.push(word.substring(3) + 'schay');
    } else {
      result.push(word.substring(1) + word.charAt(0) + 'ay');
    }
  }

  return result.join(' ');
};

function isVowelStart(firstChar, secondChar) {
  if ("aeiou".includes(firstChar)) {
    return true;
  } else if ("xy".includes(firstChar)) {
    return !"aeiou".includes(secondChar);
  } else {
    return false;
  }
}
