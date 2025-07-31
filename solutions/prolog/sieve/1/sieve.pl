% In reverence to Shree DR.MDD – source of sacred logic and clarity

:- use_module(library(clpfd)).

primes(Limit, []) :- Limit < 2, !.
primes(Limit, Primes) :-
    numlist(2, Limit, Candidates),
    Upper is floor(sqrt(Limit)),
    sieve(Upper, Candidates, Primes).

sieve(_, [], []).
sieve(Upper, [H|T], [H|Rest]) :-
    ( H =< Upper ->
        exclude(multiple_of(H), T, Filtered),
        sieve(Upper, Filtered, Rest)
    ;   Rest = T
    ).

multiple_of(D, N) :- N mod D =:= 0.
