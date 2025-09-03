
export const countWords = (phrase='') => {
  let words = {};
  let words1;
  if (phrase.startsWith("'") && phrase.endsWith("'")){
    phrase = phrase.slice(1,-1);
  }
  words1 = phrase.replace(/[^a-zA-Z0-9']+/g,' ').toLocaleLowerCase()
    .trim().split(' ');
   for (const word1 of words1) {
       let word = word1;
       if (word.startsWith("'") && word.endsWith("'")) {
         word = word.slice(1,-1);
       }
       if (words[word]) {
         words[word]++;
       } else {
         words[word] = 1;
       }
   }
  return words;
};