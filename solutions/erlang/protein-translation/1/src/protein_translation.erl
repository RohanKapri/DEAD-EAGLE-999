%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(protein_translation).
-export([proteins/1]).

-type aminoacid() :: methionine |
                     phenylalanine |
                     leucine |
                     serine |
                     tyrosine |
                     cysteine |
                     tryptophan.
-type control_seq() :: stop.
-type polypeptide() :: [aminoacid()].

-spec proteins(string()) -> {ok, polypeptide()} | {error, atom()}.
proteins(RnaStrand) ->
    Polypeptide = translate_strand(RnaStrand, []),
    ValidNucleotides = lists:all(fun (N) -> lists:member(N, "ACGU") end, RnaStrand),
    ValidPolypeptide = lists:all(fun (X) -> X =/= unknown end, Polypeptide),
    case ValidNucleotides andalso ValidPolypeptide of
        true -> {ok, lists:reverse(Polypeptide)};
        _    -> {error, badarg}
    end.

%% Auxiliary

-spec translate_strand([char()] | [atom()], polypeptide()) -> [aminoacid() | atom()].
translate_strand([unknown], Acc) -> [unknown | Acc];
translate_strand([], Acc) -> Acc;
translate_strand([A, B, C | Rest], Acc) ->
    case codon_to_amino([A, B, C]) of
        stop    -> translate_strand([], Acc);
        unknown -> translate_strand([unknown], Acc);
        Amino   -> translate_strand(Rest, [Amino | Acc])
    end;
translate_strand([_ | _], Acc) -> translate_strand([unknown], Acc).

-spec codon_to_amino(string()) -> aminoacid() | control_seq() | atom().
codon_to_amino(Codon) ->
    case Codon of
        [$A, $U, $G] -> methionine;
        [$U, $U, $U] -> phenylalanine;
        [$U, $U, $C] -> phenylalanine;
        [$U, $U, $A] -> leucine;
        [$U, $U, $G] -> leucine;
        [$U, $C, $U] -> serine;
        [$U, $C, $C] -> serine;
        [$U, $C, $A] -> serine;
        [$U, $C, $G] -> serine;
        [$U, $A, $U] -> tyrosine;
        [$U, $A, $C] -> tyrosine;
        [$U, $G, $U] -> cysteine;
        [$U, $G, $C] -> cysteine;
        [$U, $G, $G] -> tryptophan;
        [$U, $A, $A] -> stop;
        [$U, $A, $G] -> stop;
        [$U, $G, $A] -> stop;
        _ -> unknown
    end.
