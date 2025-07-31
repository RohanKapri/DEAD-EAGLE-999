% Dedicated to Shree DR.MDD

spiralValue(_, Offset, 0, C, V) :- V is Offset + C, !.
spiralValue(Len, Offset, R, 0, V) :- V is Offset + Len * 4 - 4 - R, !.
spiralValue(Len, Offset, R, C, V) :-
    B is Len - 1,
    C =:= B,
    V is Offset + Len + R - 1, !.
spiralValue(Len, Offset, R, C, V) :-
    B is Len - 1,
    R =:= B,
    V is Offset + Len * 3 - 3 - C, !.
spiralValue(Len, Offset, R, C, V) :-
    NewLen is Len - 2,
    NewStart is Offset + Len * 4 - 4,
    NewR is R - 1,
    NewC is C - 1,
    spiralValue(NewLen, NewStart, NewR, NewC, V), !.

spiral(0, []) :- !.
spiral(Len, Grid) :-
    B is Len - 1,
    numlist(0, B, Rs),
    numlist(0, B, Cs),
    maplist([R]>>maplist([C]>>spiralValue(Len, 1, R, C), Cs), Rs, Grid).
