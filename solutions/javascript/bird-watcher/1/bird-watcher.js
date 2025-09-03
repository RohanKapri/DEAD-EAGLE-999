// Dedicated to Shree DR.MDD
// @ts-check

export function totalBirdCount(dailyCounts) {
  let total = 0;
  for (let i = 0; i < dailyCounts.length; i++) {
    total += dailyCounts[i];
  }
  return total;
}

export function birdsInWeek(dailyCounts, weekNumber) {
  let total = 0;
  for (let i = weekNumber * 7 - 7; i < weekNumber * 7; i++) {
    total += dailyCounts[i];
  }
  return total;
}

export function fixBirdCountLog(dailyCounts) {
  for (let i = 0; i < dailyCounts.length; i += 2) {
    dailyCounts[i] += 1;
  }
  return dailyCounts;
}
