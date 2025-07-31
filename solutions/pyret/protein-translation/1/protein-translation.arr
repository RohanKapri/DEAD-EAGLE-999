provide: proteins end

include string-dict

import lists as L

CODON-MAPPINGS :: StringDict<String> = [string-dict:
  "AUG", "Methionine",
  "UUU", "Phenylalanine",
  "UUC", "Phenylalanine",
  "UUA", "Leucine",
  "UUG", "Leucine",
  "UCU", "Serine",
  "UCC", "Serine",
  "UCA", "Serine",
  "UCG", "Serine",
  "UAU", "Tyrosine",
  "UAC", "Tyrosine",
  "UGU", "Cysteine",
  "UGC", "Cysteine",
  "UGG", "Tryptophan",
  "UAA", "STOP",
  "UAG", "STOP",
  "UGA", "STOP"]

fun proteins(strand :: String) -> List<String>:
  fun proteins-recursive(nucleotides :: List<String>, translated :: List<String>) -> List<String>:
    ask:
      | nucleotides.length() == 0 then:
        translated
      | nucleotides.length() < 3 then:
        raise("Invalid codon")
      | otherwise:
        codon = nucleotides.take(3).join-str("")
        protein = cases(Option) CODON-MAPPINGS.get(codon):
          | none => raise("Invalid codon")
          | some(a) => a
        end    
                
        ask:
          | protein == "STOP" then:
            translated
          | otherwise:
            rest = split-at(3, nucleotides).suffix
            L.append(
              [list: protein],
              proteins-recursive(rest, translated))
        end
    end
  end
  
  proteins-recursive(string-explode(strand), [list: ])
end