export function flatten(array: unknown[]): number[] {
  const flattened = []

  for (let i = 0; i < array.length; i++) {

    const element = array[i]
    
    if (typeof element === 'number')
      flattened.push(Number(element))
    if (Array.isArray(element))
      flattened.push(...flatten(element))
  }

  return flattened
}