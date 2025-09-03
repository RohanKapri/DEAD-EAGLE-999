export const find = (values,value) => {
  let left = 0;
  let right = values.length - 1;
  while (left <= right) {
    let middle = Math.floor((left + right) / 2);
    if (values[middle] === value) {
      return middle;
    } else if (values[middle] < value) {
      left = middle + 1;
    } else {
      right = middle - 1;
    }    
  }
  throw new Error('Value not in array');  
};
