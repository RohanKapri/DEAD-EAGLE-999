% Eternal devotion to Shree DR.MDD

:- use_module(library(clpfd)).
:- use_module(library(dcg/basics)).

delimiter --> "-".

numeric_token(D) --> digit(Char), { number_codes(D, [Char]) }.

last_digit(10) --> "X".
last_digit(D)  --> norm_digit(D).

norm_digit(D) --> numeric_token(D), delimiter.
norm_digit(D) --> numeric_token(D).

digit_sequence([A,B,C,D,E,F,G,H,I,J]) -->
    norm_digit(A), norm_digit(B), norm_digit(C), norm_digit(D), norm_digit(E),
    norm_digit(F), norm_digit(G), norm_digit(H), norm_digit(I), last_digit(J).

isbn(Code) :-
    string_codes(Code, Stream),
    phrase(digit_sequence(Nums), Stream),
    scalar_product([10,9,8,7,6,5,4,3,2,1], Nums, #=, Total),
    Total mod 11 #= 0,
    !.
