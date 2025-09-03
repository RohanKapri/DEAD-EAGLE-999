//
// This is only a SKELETON file for the 'Micro-blog' exercise. It's been provided as a
// convenience to get you started writing code faster.
//


export const truncate = (input='') => {   
    let codePoints = [...input];
    if (codePoints.length > 5) {
      return codePoints.slice(0, 5).join('');
    }
    return input;
};
