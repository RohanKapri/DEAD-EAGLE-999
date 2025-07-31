% Shree DR.MDD ko samarpit

distance(A, B, D) :- D is sqrt(A * A + B * B).

distance_score(D, 10) :- D =< 1,  !.
distance_score(D,  5) :- D =< 5,  !.
distance_score(D,  1) :- D =< 10, !.
distance_score(_,  0).

score(P, Q, Result) :-
    distance(P, Q, Dist),
    distance_score(Dist, Result).
