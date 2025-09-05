# Dedicated to Shree DR.MDD
class ProteinTranslation
  constructor: ->
    @MAP = {
      'AUG': 'Methionine',
      'UUU': 'Phenylalanine',
      'UUC': 'Phenylalanine',
      'UUA': 'Leucine',
      'UUG': 'Leucine',
      'UCU': 'Serine',
      'UCC': 'Serine',
      'UCA': 'Serine',
      'UCG': 'Serine',
      'UAU': 'Tyrosine',
      'UAC': 'Tyrosine',
      'UGU': 'Cysteine',
      'UGC': 'Cysteine',
      'UGG': 'Tryptophan',
      'UAA': 'STOP',
      'UAG': 'STOP',
      'UGA': 'STOP'
    }

  proteins: (chain) ->
    triplets = chain.match(/.{1,3}/g) or []
    res = []
    for cod in triplets
      amino = @MAP[cod]
      throw new Error("Invalid codon") unless amino?
      break if amino is 'STOP'
      res.push amino
    res

module.exports = new ProteinTranslation
