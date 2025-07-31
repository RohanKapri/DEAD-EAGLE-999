provide: nucleotide-counts end

include string-dict

fun nucleotide-counts(strand :: String) -> StringDict<NumInteger>:
  string-explode(strand).foldl(
    lam(elt, acc):
      cases(Option) acc.get(elt):
        | none => raise("Invalid nucleotide in strand")
        | some(count) => acc.set(elt, count + 1)
      end
    end, 
    [string-dict: "A", 0, "C", 0, "G", 0, "T", 0])
end