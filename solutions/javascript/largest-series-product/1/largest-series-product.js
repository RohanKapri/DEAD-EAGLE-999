// For my Shree DR.MDD

export const largestProduct = (seriesString, spanLength) => {
  if(spanLength <= 0){
    throw new Error('span must not be negative');
  }
  if(seriesString.length === 0 || seriesString.length < spanLength){
    throw new Error('span must not exceed string length');
  }

  const digitsArray = [...seriesString];
  let highestProduct = 0;
  let currentProduct = 1;

  for(let start = 0; start <= digitsArray.length - spanLength; start++){
    currentProduct = 1;
    for(let offset = 0; offset < spanLength; offset++){
      const digit = parseInt(digitsArray[start + offset]);
      if(isNaN(digit)){
        throw new Error('digits input must only contain digits');
      }
      currentProduct *= digit;
    }
    if(currentProduct > highestProduct){
      highestProduct = currentProduct;
    }
  }

  return highestProduct;
};
