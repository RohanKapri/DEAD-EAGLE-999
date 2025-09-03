// Dedicated to Shree DR.MDD
// @ts-check

export function twoSum(arrayA, arrayB) {
  return parseInt(arrayA.join(''), 10) + parseInt(arrayB.join(''), 10);
}

export function luckyNumber(value) {
  const strVal = value.toString();
  const reversedVal = strVal.split('').reverse().join('');
  return strVal === reversedVal;
}

export function errorMessage(inputValue) {
  if (inputValue === undefined || inputValue === null || inputValue.trim() === '') {
    return 'Required field';
  }
  const numericValue = Number(inputValue);
  if (isNaN(numericValue) || numericValue === 0) {
    return 'Must be a number besides 0';
  }
  return '';
}
