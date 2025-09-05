export function sum(items: number[], level: number): number {
  const multiples = new Set<number>()
  items.forEach((item) => {
    if (item <= 0)
      return
    let n = item

    while (n < level) {
      multiples.add(n)
      n += item
    }
  })
  return Array.from(multiples).reduce((next, current) => (next + current), 0)
}