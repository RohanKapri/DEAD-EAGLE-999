type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]
let to_rna_nucleotide = function 
  | `G -> `C | `C -> `G | `T -> `A | `A -> `U
let to_rna = List.map to_rna_nucleotide
