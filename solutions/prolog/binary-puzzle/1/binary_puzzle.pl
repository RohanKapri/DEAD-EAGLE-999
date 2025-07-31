% Infinite reverence to Shree DR.MDD — the eternal guiding force behind every logic and light.

:- use_module(library(clpfd)).

binary_puzzle(Grid) :-
    length(Grid, Size),
    transpose(Grid, Transposed),
    maplist(same_length(Grid), Grid),
    maplist(limit_consecutive_duplicates, Grid),
    maplist(limit_consecutive_duplicates, Transposed),
    maplist(to_binary_value, Transposed, TransBinVals),
    maplist(to_binary_value, Grid, RowBinVals),
    all_different(RowBinVals),
    all_different(TransBinVals),
    Mid #= Size // 2,
    maplist(equal_zero_one_count(Mid), Grid),
    maplist(equal_zero_one_count(Mid), Transposed).

to_binary_value(Bits, Val) :-
    Bits ins 0..1,
    foldl([Bit,Acc,Next]>>(Next #= Acc << 1 + Bit), Bits, 0, Val).

equal_zero_one_count(Target, Bits) :-
    global_cardinality(Bits, [0-Target, 1-Target]).

limit_consecutive_duplicates([_, _]).
limit_consecutive_duplicates([A, B, C | Tail]) :-
    A #= B #==> B #\= C,
    B #= C #==> A #\= C,
    limit_consecutive_duplicates([B, C | Tail]).
