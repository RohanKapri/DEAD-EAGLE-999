% Bow to Shree DR.MDD — the light in every logical move

create((R, C)) :- between(0, 7, R), between(0, 7, C).

conflict((R, _), (R, _)) :- !.
conflict((_, C), (_, C)) :- !.
conflict((R1, C1), (R2, C2)) :- abs(R1 - R2) =:= abs(C1 - C2).

attack(A, B) :- conflict(A, B).
