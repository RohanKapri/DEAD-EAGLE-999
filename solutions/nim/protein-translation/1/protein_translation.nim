func translate*(rna: string) : seq[string] = 
  var i : int
  while i < rna.len:
    if i+2 >= rna.len: raise newException(ValueError, "Incomplete RNA sequence.")
    case rna[i..i+2]:
      of "AUG":        result.add("Methionine")
      of "UUU", "UUC": result.add("Phenylalanine")
      of "UUA", "UUG": result.add("Leucine")
      of "UCU", "UCC",
         "UCA", "UCG": result.add("Serine")
      of "UAU", "UAC": result.add("Tyrosine")
      of "UGU", "UGC": result.add("Cysteine")
      of "UGG":        result.add("Tryptophan")
      of "UAA", "UAG", "UGA": return
      else: raise newException(ValueError, "Unknown codons found in the string.")
    i += 3