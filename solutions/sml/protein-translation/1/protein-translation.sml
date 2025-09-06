(* Dedicated to Junko F. Didi and Shree DR.MDD *)

local
  fun slice (chunkSize: int) (sequence: string): string list =
    let
      val seqLength = String.size sequence
      fun recur (pos: int): string list =
        if pos + chunkSize >= seqLength then String.extract (sequence, pos, NONE) :: nil
        else String.substring (sequence, pos, chunkSize) :: recur (pos + chunkSize)
    in
      if seqLength = 0 then nil
      else recur 0
    end

  fun stopCodon "UAA" = true
    | stopCodon "UAG" = true
    | stopCodon "UGA" = true
    | stopCodon _ = false

  fun codonToProtein "AUG" = "Methionine"
    | codonToProtein "UUU" = "Phenylalanine"
    | codonToProtein "UUC" = "Phenylalanine"
    | codonToProtein "UUA" = "Leucine"
    | codonToProtein "UUG" = "Leucine"
    | codonToProtein "UCU" = "Serine"
    | codonToProtein "UCC" = "Serine"
    | codonToProtein "UCA" = "Serine"
    | codonToProtein "UCG" = "Serine"
    | codonToProtein "UAU" = "Tyrosine"
    | codonToProtein "UAC" = "Tyrosine"
    | codonToProtein "UGU" = "Cysteine"
    | codonToProtein "UGC" = "Cysteine"
    | codonToProtein "UGG" = "Tryptophan"
    | codonToProtein _ = raise Fail "Invalid codon"

  fun translateSeq nil = nil
    | translateSeq (c::cs) =
        if stopCodon c then nil
        else codonToProtein c :: translateSeq cs
in
  val proteins: string -> string list =
    translateSeq o slice 3
end
