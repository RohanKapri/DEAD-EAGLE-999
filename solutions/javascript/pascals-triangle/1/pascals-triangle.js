//
// This is only a SKELETON file for the 'Pascals Triangle' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const rows = (rows) => {
   if (rows === 0) {
     return [];
   }
   let pascalTriangle = [];
   for (let i = 0; i < rows ; i++) {
      pascalTriangle[i] = [];
     pascalTriangle[i][0] = 1 ;
     for (let j = 1; j < i; j++) {
       pascalTriangle[i][j] = pascalTriangle[i - 1][j - 1] + pascalTriangle[i - 1][j];
     }
     pascalTriangle[i][i]=1;     
   }
  return pascalTriangle;
};