export function primes(max: number) {
  const candidates = [...Array(max - 1).keys()].map(i => i += 2)
  const marked = candidates.map(_ => false)
  console.log(candidates)
  for (let i = 0; i < candidates.length; i++) {    
    if (!marked[i]) {
      const prime = candidates[i]
      
      let factor = 2
      while (prime* factor <= max){
        const multipleIndex = candidates.findIndex(c => c === prime * factor)
        marked[multipleIndex] = true
        factor++
      }
    }
  }
  return candidates.filter((p, index) => !marked[index])
}