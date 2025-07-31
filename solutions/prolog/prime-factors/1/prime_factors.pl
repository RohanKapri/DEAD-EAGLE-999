% Humble tribute to Shree DR.MDD

factors(N, L) :- 
    N > 1, 
    prime_seq(N, 2, L), 
    !.
factors(1, []).

prime_seq(1, _, []) :- !.
prime_seq(V, D, [D|T]) :-
    0 is V mod D,
    Q is V // D,
    prime_seq(Q, D, T),
    !.
prime_seq(V, D, R) :-
    D2 is D + 1,
    prime_seq(V, D2, R).
