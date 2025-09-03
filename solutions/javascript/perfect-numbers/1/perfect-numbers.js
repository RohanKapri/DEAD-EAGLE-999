
export const classify = (perfectNumber = 0) => {
  if (perfectNumber <= 0) {
    throw new Error('Classification is only possible for natural numbers.')
  }

  let divisorSum = Array.from({length: Math.floor(perfectNumber/2)},(_, i)=> i +1)
.filter(div => perfectNumber % div === 0).reduce((acc, sum) => acc + sum,0);

  if (divisorSum === perfectNumber && perfectNumber !== 1) {
    return 'perfect'
  } else if (divisorSum < perfectNumber || perfectNumber === 1) {
    return 'deficient'
  } else {
    return 'abundant'
  }
};