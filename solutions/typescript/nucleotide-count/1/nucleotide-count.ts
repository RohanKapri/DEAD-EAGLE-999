const NUCLEOTIDES = ['A', 'C', 'G', 'T'] as const
type Nucleotide = typeof NUCLEOTIDES[number]
const isNucleotide = (char: string): char is Nucleotide => (NUCLEOTIDES as readonly string[]).includes(char)
export function nucleotideCounts(dnaSequence: string): Record<Nucleotide, number> {
  const nucleotideCount = {
    A: 0,
    C: 0,
    G: 0,
    T: 0,
  } as Record<Nucleotide, number>
  dnaSequence.split('').forEach((char: string) => {
    if (!isNucleotide(char))
      throw new Error('Invalid nucleotide in strand')
    nucleotideCount[char]++
  })
  return nucleotideCount
}