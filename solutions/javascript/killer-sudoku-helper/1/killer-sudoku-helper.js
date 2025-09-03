
export const combinations = (cage) => {
  const { sum, size, exclude } = cage;
  const nums = [1, 2, 3, 4, 5, 6, 7, 8, 9].filter(num => !exclude.includes(num));
  
  const result = [];

  const findCombinations = (currentCombination, currentIndex, currentSum) => {
    if (currentCombination.length === size) {
      if (currentSum === sum) {
        result.push([...currentCombination]);
      }
      return;
    }

    for (let i = currentIndex; i < nums.length; i++) {
      const num = nums[i];
      if (currentSum + num > sum) continue;
      currentCombination.push(num);
      findCombinations(currentCombination, i + 1, currentSum + num);
      currentCombination.pop();
    }
  };

  findCombinations([], 0, 0);
  return result;
};