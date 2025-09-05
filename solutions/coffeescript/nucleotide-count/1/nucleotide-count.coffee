class NucleotideCount
  constructor: (@dna = '') ->
    @nucleotideCounts = { A: 0, T: 0, C: 0, G: 0 }
    for nucleotide in @dna
      if @nucleotideCounts[nucleotide]? 
        @nucleotideCounts[nucleotide] += 1
      else
        throw new Error('Invalid nucleotide strand')

  count: (nucleotide) ->
    if @nucleotideCounts[nucleotide]?
      return @nucleotideCounts[nucleotide]
    else
      throw new Error('Invalid nucleotide')

module.exports = NucleotideCount