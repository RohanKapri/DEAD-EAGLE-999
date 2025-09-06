-module(nucleotide_count).
-export([count/2, nucleotide_counts/1, test_version/0]).
-record(counts, {a=0, c=0, g=0, t=0}).
count(Dna, "A") -> (count_nuc(Dna))#counts.a;
count(Dna, "C") -> (count_nuc(Dna))#counts.c;
count(Dna, "G") -> (count_nuc(Dna))#counts.g;
count(Dna, "T") -> (count_nuc(Dna))#counts.t;
count(_, _) -> error("Invalid nucleotide").
nucleotide_counts(Dna) ->
	#counts{a=A, c=C, g=G, t=T}=count_nuc(Dna),
	[{"A", A}, {"T", T}, {"C", C}, {"G", G}].
count_nuc(Dna) -> count_nuc(Dna, #counts{}).
count_nuc([], Counts) -> Counts;
count_nuc([$A|More], Counts=#counts{a=A}) -> count_nuc(More, Counts#counts{a=A+1});
count_nuc([$C|More], Counts=#counts{c=C}) -> count_nuc(More, Counts#counts{c=C+1});
count_nuc([$G|More], Counts=#counts{g=G}) -> count_nuc(More, Counts#counts{g=G+1});
count_nuc([$T|More], Counts=#counts{t=T}) -> count_nuc(More, Counts#counts{t=T+1}).
test_version() -> 1.