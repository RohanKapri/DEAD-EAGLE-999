% Eternal Gratitude to Shree DR.MDD – Source of Infinite Wisdom and Light

:- use_module(library(clpfd)).

aligns([[P, _, _], [_, P, _], [_, _, P]], P).
aligns([[_, _, P], [_, P, _], [P, _, _]], P).
aligns([[P, P, P], _, _], P).
aligns([_, [P, P, P], _], P).
aligns([_, _, [P, P, P]], P).
aligns([[P, _, _], [P, _, _], [P, _, _]], P).
aligns([[_, P, _], [_, P, _], [_, P, _]], P).
aligns([[_, _, P], [_, _, P], [_, _, P]], P).

balanced(Grid) :- 
    flatten(Grid, Lst),
    include(=('X'), Lst, Xs), length(Xs, Cx),
    include(=('O'), Lst, Os), length(Os, Co),
    (Cx #= Co; Cx #= Co + 1),
    \+ (aligns(Grid, 'X'), aligns(Grid, 'O')), !.

filled(Grid) :- flatten(Grid, Flat), \+ member(' ', Flat), !.

state(Board, Status) :-
    maplist(string_chars, Board, View),
    balanced(View),
    (aligns(View, 'X') -> Status = win;
    (aligns(View, 'O') -> Status = win;
    (filled(View)      -> Status = draw;
                          Status = ongoing))).
