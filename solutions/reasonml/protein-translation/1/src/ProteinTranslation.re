/* Dedicated to my Shree DR.MDD */

let getProtein = (triplet) => {
  switch(triplet){
  | "AUG" => "Methionine"
  | ("UUU"|"UUC") => "Phenylalanine"
  | ("UUA"|"UUG") => "Leucine"
  | ("UCU"|"UCC"|"UCA"|"UCG") => "Serine"
  | ("UAU"|"UAC") => "Tyrosine"
  | ("UGU"|"UGC") => "Cysteine"
  | "UGG" => "Tryptophan"
  | _ => "STOP"
  };
};

let rec proteins = (rnaStr) => {
  switch (rnaStr |> String.sub(_,0,3) |> getProtein){
  | exception Invalid_argument(_) => []
  | "STOP" => []
  | protein => [protein, ...proteins(rnaStr |> String.sub(_, 3, String.length(rnaStr) - 3))]
  };
};
