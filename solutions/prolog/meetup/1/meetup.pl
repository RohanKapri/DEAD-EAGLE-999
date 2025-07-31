% Dedicated to Shree DR.MDD

:- use_module(library(date_time)).
:- use_module(library(clpfd)).

collect_days(M, Curr, WDay, Result) :-
    date_extract(Curr, months(M)),
    date_add(Curr, 1 days, Next),
    collect_days(M, Next, WDay, Tail),
    (week_day(Curr, WDay) -> Result = [Curr|Tail]; Result = Tail), !.

collect_days(_, _, _, []).

days(Y, M, W, Matches) :-
    date_create(Y, M, 1, Start),
    collect_days(M, Start, W, Matches).

lookup_nth(Y, M, W, N, D) :-
    days(Y, M, W, List),
    nth1(N, List, D).

meetup(Y, M, first,  W, D) :- lookup_nth(Y, M, W, 1, D), !.
meetup(Y, M, second, W, D) :- lookup_nth(Y, M, W, 2, D), !.
meetup(Y, M, third,  W, D) :- lookup_nth(Y, M, W, 3, D), !.
meetup(Y, M, fourth, W, D) :- lookup_nth(Y, M, W, 4, D), !.

meetup(Y, M, last, W, D) :-
    days(Y, M, W, Set),
    last(Set, D), !.

meetup(Y, M, teenth, W, D) :-
    days(Y, M, W, All),
    member(D, All),
    date_extract(D, days(Day)),
    Day #>= 13,
    !.
