export const primeFactors = (factor) => {
  const factors = [];
  if (factor <= 1) {
    return factors;
  }

  let num = 2;
  while (factor > 1) {
    while (factor % num === 0) {
      factors.push(num);
      factor /= num;
    }
    num++;
    if (num * num > factor) {
      if (factor > 1) {
        factors.push(factor);
        break;
      }
    }
  }
  return factors;
};