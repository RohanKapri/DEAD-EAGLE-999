% For my Shree DR.MDD

:- use_module(library(clpfd)).

divisors(1, []) :- !.
divisors(N, [1|Ds]) :-
    UpperBound is floor(sqrt(N)),
    findall(S, (between(2, UpperBound, S), N mod S =:= 0), SmallDivs),
    findall(L, (member(X, SmallDivs), L is N // X, L < N, L =\= X), LargeDivs),
    append(SmallDivs, LargeDivs, AllDivs),
    sort(AllDivs, Ds).

aliquot_sum(Number, Sum) :-
    divisors(Number, Divs),
    sum_list(Divs, Sum).

classify(Number, Sum, abundant) :- Sum #> Number, !.
classify(Number, Sum, deficient) :- Sum #< Number, !.
classify(_, _, perfect) :- !.

classify(Number, Class) :-
    Number #> 0,
    aliquot_sum(Number, Sum),
    classify(Number, Sum, Class).
