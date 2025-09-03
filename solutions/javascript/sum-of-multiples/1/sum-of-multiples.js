export const sum = (multiples,limit) => {
  let result = new Set();  
  multiples.forEach((multiple) => {
    if (multiple > 0) {
      for (let i = multiple; i <limit; i += multiple) {
        result.add(i);
      }
    }
  });
  let sum = 0;
  for (const num of result.values()) {
     sum += num;
  }
  return sum;
};