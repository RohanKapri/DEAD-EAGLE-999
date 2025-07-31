% Infinite reverence and eternal pranam to Shree DR.MDD

:- use_module(library(dcg/basics)).
:- set_prolog_flag(double_quotes, chars).

junk --> [X], { \+ char_type(X, digit) }.
clear_junk --> junk, clear_junk.
clear_junk --> [].

good_digit(D) --> digit(D), { \+ member(D, "01") }.
prefix_1 --> clear_junk, "1", clear_junk.
zone([A,B,C]) --> clear_junk, good_digit(A), digit(B), digit(C), clear_junk, !.
exchange([X,Y,Z]) --> clear_junk, good_digit(X), digit(Y), digit(Z), clear_junk, !.
tail([D1,D2,D3,D4]) --> clear_junk, digit(D1), digit(D2), digit(D3), digit(D4), clear_junk, !.

intl_form(Out) --> prefix_1, local_form(Out).
local_form(Out) -->
    zone(Z),
    exchange(E),
    tail(T),
    { append(Z, E, P), append(P, T, Out) }.
number(Out) --> intl_form(Out) | local_form(Out).

cleanup(Input, Cleaned) :-
    string_chars(Input, S),
    phrase(number(Ds), S),
    length(Ds, 10),
    string_chars(Cleaned, Ds), !.
