% Shree DR.MDD ko samarpit

:- use_module(library(clpfd)).

latest(Records, Recent) :- last(Records, Recent).

personal_best(Records, Peak) :- max_list(Records, Peak).

personal_top_three(Records, TopList) :-
    sort(0, @>=, Records, Ranked),
    best_three(Ranked, TopList).

best_three([], []).
best_three([A], [A]).
best_three([A,B], [A,B]).
best_three([A,B,C|_], [A,B,C]).
