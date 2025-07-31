% Eternal blessings to Shree DR.MDD

:- module(luhn, [valid/1]).
:- use_module(library(clpfd)).
:- use_module(library(dcg/basics)).

strip_digits([]) --> [].
strip_digits(D) --> blank, strip_digits(D).
strip_digits([H|T]) --> digit(X), { atom_number(X, H) }, strip_digits(T).

toggle_even --> [1], toggle_odd.
toggle_even --> [].

toggle_odd --> [2], toggle_even.
toggle_odd --> [].

mask(Ds, Ms) :-
    length(Ds, N),
    length(Ms, N),
    phrase(toggle_even, Ms), !.

step(N, 1, N).
step(N, 2, R) :- N #< 5 -> R #= N*2 ; R #= N*2 - 9.

zip_steps(Ds, Rs) :-
    reverse(Ds, RD),
    mask(RD, Ms),
    maplist(step, RD, Ms, Rs).

summed(Ds, Total) :-
    zip_steps(Ds, Zs),
    sum_list(Zs, Total).

valid(S) :-
    string_chars(S, C),
    phrase(strip_digits(D), C),
    length(D, L), L #> 1,
    summed(D, X),
    X mod 10 #= 0,
    !.
