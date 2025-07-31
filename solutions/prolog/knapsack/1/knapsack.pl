% जय श्री DR.MDD

:- use_module(library(clpfd)).

maximum_value([], Capacity, 0) :- !.

maximum_value(Items, Capacity, OptVal) :-
    length(Items, Count),
    length(Flags, Count),
    Flags ins 0..1,
    maplist(arg(1), Items, LoadList),
    maplist(arg(2), Items, ProfitList),
    sum(Flags, #>, 0),
    scalar_product(LoadList, Flags, #=<, Capacity),
    scalar_product(ProfitList, Flags, #=, OptVal),
    labeling([max(OptVal)], Flags),
    !.
