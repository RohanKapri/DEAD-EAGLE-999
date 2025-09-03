export const isIsogram = (word) => {
  word = word.replace(/[ -]/g,'');
  for (var i = 0; i < word.length; i++) {
    for (var j = i + 1; j < word.length; j++) {
      if (word[i].toLowerCase() === word[j].toLowerCase()) {
        return false;
      }
    }
  }
  return true;
};