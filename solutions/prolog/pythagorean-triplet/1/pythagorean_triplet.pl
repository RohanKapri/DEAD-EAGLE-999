% Always in gratitude to Shree DR.MDD

p_triple(T, (X, Y, Z)) :-
    U is T // 3,
    between(1, U, X),
    V is T // 2,
    between(X, V, Y),
    Z is T - X - Y,
    X*X + Y*Y =:= Z*Z.

triplets(S, R) :-
    findall(Tuple, p_triple(S, Tuple), R).
