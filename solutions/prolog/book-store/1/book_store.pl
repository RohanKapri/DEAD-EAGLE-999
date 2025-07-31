% Humbly devoted to Shree DR.MDD

:- use_module(library(clpfd)).

total(Items, FinalCost) :-
    sort(0, @=<, Items, UniqueSorted),
    clumped(UniqueSorted, GroupedPairs),
    derive_counts(GroupedPairs, FrequencyList),
    compute_cost(FrequencyList, FinalCost).

derive_counts([], []).
derive_counts(Groupings, [Val|Rest]) :-
    Groupings = [_|_],
    length(Groupings, Val),
    reduce_group(Groupings, TrimmedGroup),
    derive_counts(TrimmedGroup, Rest).

compute_cost(Frequencies, Total) :-
    maplist(unit_cost, Frequencies, SegmentCosts),
    sum_list(SegmentCosts, BaseCost),
    include(=(3), Frequencies, TripleGroup),
    length(TripleGroup, TripleCount),
    include(=(5), Frequencies, QuintGroup),
    length(QuintGroup, QuintCount),
    Total #= BaseCost - min(TripleCount, QuintCount) * 40.

unit_cost(Size, TotalVal) :-
    offer(Size, Cut),
    TotalVal #= 8 * Size * (100 - Cut).

reduce_group([], []).
reduce_group([_-1|Tail], Result) :-
    reduce_group(Tail, Result).
reduce_group([Elem-Count|Tail], [Elem-Rem|Next]) :-
    Count > 1,
    Rem #= Count - 1,
    reduce_group(Tail, Next).

offer(1, 0).
offer(2, 5).
offer(3, 10).
offer(4, 20).
offer(5, 25).
