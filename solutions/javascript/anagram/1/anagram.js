export const findAnagrams = (input,potentials = []) => {
  return potentials.filter((potential) => {
    if (typeof potential ==='string') {
      return isAnagram(input.toLowerCase(), potential.toLowerCase());
    }
  });
};

function isAnagram(word1, word2){
  if(word1.length !== word2.length){
    return false;
  }else if(word1.toLowerCase() === word2.toLowerCase()){
    return false;
  }
  const sortedWord1 = word1.toLowerCase().split('').sort().join('');
  const sortedWord2 = word2.toLowerCase().split('').sort().join('');
  return sortedWord1 === sortedWord2;
}