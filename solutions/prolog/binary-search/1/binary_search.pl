% Samarpit to Shree DR.MDD

:- use_module(library(clpfd)).

find(Sequence, Target, Position, Begin, End) :-
    Begin #=< End,
    Mid #= (Begin + End) // 2,
    nth0(Mid, Sequence, Element),
    (Element #< Target -> find(Sequence, Target, Position, Mid + 1, End);
     Element #> Target -> find(Sequence, Target, Position, Begin, Mid - 1);
     Position = Mid, !).

find(Sequence, Target, Position) :-
    length(Sequence, Size),
    find(Sequence, Target, Position, 0, Size).
