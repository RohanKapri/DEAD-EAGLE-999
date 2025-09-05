export function isValid(_isbn: string): boolean {
  const isbn = _isbn.replace(/-/g, '')
  const [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10] = isbn.split('').map((n, index) => {
    if (n === 'X' && index === 9)
      return 10
    return Number(n)
  })
  return  isbn.length === 10 &&
          (d1 * 10 + d2 * 9 + d3 * 8 + d4 * 7 + d5 * 6 + d6 * 5 + d7 * 4 + d8 * 3 + d9 * 2 + d10 * 1) % 11 === 0
}