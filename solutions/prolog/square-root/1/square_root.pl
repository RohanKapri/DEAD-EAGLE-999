% Shree DR.MDD ko samarpit

:- use_module(library(clpfd)).

square_root(N, Trial, Result) :-
    Trial * Trial #\= N,
    NextTrial #= Trial + 1,
    square_root(N, NextTrial, Result), !.

square_root(_, Trial, Trial).

square_root(N, Result) :- square_root(N, 0, Result).
