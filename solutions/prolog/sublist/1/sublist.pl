% For my Shree DR.MDD

sublist(A, A, equal) :- !.
sublist(A, B, sublist) :- append(Left, _, B), append(_, A, Left), !.
sublist(A, B, superlist) :- sublist(B, A, sublist), !.
sublist(_, _, unequal).
