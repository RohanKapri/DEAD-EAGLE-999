export function find(haystack: number[], needle: number): number | never {
  if (haystack.length === 0)
    throw Error('Value not in array')
  const index = Math.floor(haystack.length - 1 / 2)
  const difference = needle - haystack[index]
  if (difference < 0)
    return find(haystack.slice(0, index), needle)
  if (difference > 0)
    return index + find(haystack.slice(index + 1), needle)
  return index
}
 