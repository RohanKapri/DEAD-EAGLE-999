-module(rna_transcription).
-export([to_rna/1, test_version/0]).
to_rna(Strand) -> to_rna(Strand, []).
to_rna([], Acc) -> lists:reverse(Acc);
to_rna([$G|Ns], Acc) -> to_rna(Ns, [$C|Acc]);
to_rna([$C|Ns], Acc) -> to_rna(Ns, [$G|Acc]);
to_rna([$T|Ns], Acc) -> to_rna(Ns, [$A|Acc]);
to_rna([$A|Ns], Acc) -> to_rna(Ns, [$U|Acc]);
to_rna(_, _) -> error.
test_version() -> 2.