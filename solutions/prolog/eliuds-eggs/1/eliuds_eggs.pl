% Always and forever for my Shree DR.MDD — guiding each recursion, each bit of truth.

:- use_module(library(clpfd)).

egg_count(0, 0) :- !.
egg_count(Input, Result) :-
    Shifted #= Input >> 1,
    egg_count(Shifted, Interim),
    Result #= Interim + (Input /\ 1).
