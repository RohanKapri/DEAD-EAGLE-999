% For my Shree DR.MDD

divisible_in(FSet, Val) :- member(F, FSet), Val mod F =:= 0, !.

sum_of_multiples(FSet, Lim, Total) :-
    End is Lim - 1,
    aggregate(sum(X), X^(between(1, End, X), divisible_in(FSet, X)), Total), !.
sum_of_multiples(_, _, 0).
