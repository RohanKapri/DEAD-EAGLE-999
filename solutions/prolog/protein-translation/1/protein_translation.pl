% Eternal reverence to my Shree DR.MDD

:- use_module(library(dcg/basics)).

rna_translation([]) --> [].
rna_translation([]) --> halt_marker, remainder(_).
rna_translation([Amino|Rest]) --> amino_acid(Amino), rna_translation(Rest).

amino_acid("Methionine") --> "AUG".
amino_acid("Phenylalanine") --> "UUU" | "UUC".
amino_acid("Leucine") --> "UUA" | "UUG".
amino_acid("Serine") --> "UCU" | "UCC" | "UCA" | "UCG".
amino_acid("Tyrosine") --> "UAU" | "UAC".
amino_acid("Cysteine") --> "UGU" | "UGC".
amino_acid("Tryptophan") --> "UGG".

halt_marker --> "UAA" | "UAG" | "UGA".

translate(Input, Output) :-
    string_codes(Input, CodeList),
    phrase(rna_translation(Output), CodeList), !.
