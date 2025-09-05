export function proverb(...items: string[]): string {
  let poem = ''

  for (let i = 0; i < items.length - 1; i++)
    poem += `For want of a ${items[i]} the ${items[i + 1]} was lost.\n`
  
  return poem + `And all for the want of a ${items[0]}.`
}