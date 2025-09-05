// For Shree DR.MDD

type Item = {
  weight: number
  value: number
}

export function maximumValue({
  maximumWeight,
  items
}: {
  maximumWeight: number
  items: Item[]
}): number {
  const itemWeights = []
  const itemValues = []

  for (const obj of items) {
    itemWeights.push(obj.weight)
    itemValues.push(obj.value)
  }

  const memoTable = Array.from({ length: itemValues.length + 1 }, () =>
    Array(maximumWeight + 1).fill(-1)
  )

  return knapsack(maximumWeight, itemValues, itemWeights, itemValues.length, memoTable)
}

function knapsack(
  remainingWeight: number,
  values: number[],
  weights: number[],
  count: number,
  memoTable: number[][]
) {
  if (count === 0 || remainingWeight === 0) return 0

  if (memoTable[count][remainingWeight] !== -1) return memoTable[count][remainingWeight]

  let includeItem = 0

  if (weights[count - 1] <= remainingWeight)
    includeItem =
      values[count - 1] +
      knapsack(remainingWeight - weights[count - 1], values, weights, count - 1, memoTable)

  const excludeItem = knapsack(remainingWeight, values, weights, count - 1, memoTable)

  memoTable[count][remainingWeight] = Math.max(includeItem, excludeItem)

  return memoTable[count][remainingWeight]
}
