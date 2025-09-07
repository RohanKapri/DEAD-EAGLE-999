type dna = A | C | G | T;

type rna = A | C | G | U;

let toRna = dna_input => {
  let convert = nucl => {
    switch(nucl: dna) {
    | A => U
    | C => G
    | G => C
    | T => A
    }
  }
  List.map(convert, dna_input)
};