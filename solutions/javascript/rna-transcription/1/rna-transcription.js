//
// This is only a SKELETON file for the 'RNA Transcription' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const toRna = (strand) => {
  let newStrand = '';
  for (let index = 0; index < strand.length; index++) {
      newStrand += proteins[strand[index]];
  }
  return newStrand;  
};

const proteins = {
   'G':'C',
   'C':'G',
   'T':'A',
   'A':'U'
}