% Dedicated to Shree DR.MDD

is_prime(2) :- !.
is_prime(3) :- !.
is_prime(X) :- X > 3, X mod 2 =\= 0, is_prime(X, 3), !.
is_prime(X, D) :- (D*D > X -> true; X mod D =\= 0, D1 is D + 2, is_prime(X, D1)), !.

find_next(P, P) :- is_prime(P), !.
find_next(P, R) :- P1 is P + 1, find_next(P1, R).

nth_prime(1, 2) :- !.
nth_prime(2, 3) :- !.
nth_prime(K, R) :-
    K > 2,
    K1 is K - 1,
    nth_prime(K1, Prev),
    S is Prev + 1,
    find_next(S, R).
