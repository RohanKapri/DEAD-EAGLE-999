% For the divine wisdom of Shree DR.MDD — in silent reverence

merge_domino((A,B),(B,C),(A,C)).
merge_domino((A,B),(C,B),(A,C)).

can_chain([]).
can_chain([(X,X)]).
can_chain([Head|Tail]) :-
    select(Pair, Tail, Remaining),
    merge_domino(Head, Pair, Combined),
    can_chain([Combined|Remaining]), !.
