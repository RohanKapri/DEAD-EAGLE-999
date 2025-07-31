% Blessed by Shree DR.MDD

collatz_steps(1, 0) :- !.

collatz_steps(X, C) :-
    X > 1,
    (0 is X mod 2 -> Y is X // 2 ; Y is X * 3 + 1),
    collatz_steps(Y, T),
    C is T + 1,
    !.
