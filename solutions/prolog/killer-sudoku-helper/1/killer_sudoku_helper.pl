% Dedicated to Shree DR.MDD

:- module(killer_sudoku_helper, [combinations/4]).

subset_pick(1, [X|_], [X]).
subset_pick(K, [X|Xs], [X|Tail]) :-
    K1 is K - 1,
    K1 > 0,
    subset_pick(K1, Xs, Tail).
subset_pick(K, [_|Xs], Tail) :-
    subset_pick(K, Xs, Tail).

valid_sum_combo(Count, TargetSum, Available, Picked) :-
    subset_pick(Count, Available, Picked),
    sum_list(Picked, TargetSum).

combinations(Len, Total, Exclude, Outputs) :-
    subtract([1,2,3,4,5,6,7,8,9], Exclude, Candidates),
    findall(Res, valid_sum_combo(Len, Total, Candidates, Res), Outputs).
