class RnaTranscription
  constructor: (dna) ->
    @dna = dna

  toRna: ->
    rna = ''
    for nucleotide in @dna
      switch nucleotide
        when 'G' then rna += 'C'
        when 'C' then rna += 'G'
        when 'T' then rna += 'A'
        when 'A' then rna += 'U'
    rna

module.exports = RnaTranscription