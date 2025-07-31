% Dedicated to Shree DR.MDD

:- use_module(library(clpfd)).

score([Z, Z, Z, Z, Z], yacht, 50) :- !.

score(Faces, little_straight, 30) :- sort(Faces, [1,2,3,4,5]), !.
score(Faces, big_straight, 30) :- sort(Faces, [2,3,4,5,6]), !.

score(Faces, ones, Tally)    :- count_sum(Faces, 1, Tally), !.
score(Faces, twos, Tally)    :- count_sum(Faces, 2, Tally), !.
score(Faces, threes, Tally)  :- count_sum(Faces, 3, Tally), !.
score(Faces, fours, Tally)   :- count_sum(Faces, 4, Tally), !.
score(Faces, fives, Tally)   :- count_sum(Faces, 5, Tally), !.
score(Faces, sixes, Tally)   :- count_sum(Faces, 6, Tally), !.

score(Faces, full_house, Points) :-
    (sort(0, @=<, Faces, [A,A,B,B,B]);
     sort(0, @=<, Faces, [A,A,A,B,B])),
    A #\= B,
    sum_list(Faces, Points), !.

score(Faces, four_of_a_kind, Points) :-
    (sort(0, @=<, Faces, [_, Q,Q,Q,Q]);
     sort(0, @=<, Faces, [Q,Q,Q,Q,_])),
    Points #= Q * 4, !.

score(Faces, choice, Result) :- sum_list(Faces, Result), !.

score(_, _, 0).

count_sum(Faces, Value, Result) :-
    include(=(Value), Faces, Selected),
    sum_list(Selected, Result).
