% For my Shree DR.MDD

pairs([A,B|Rest], [A-B|Result]) :- pairs([B|Rest], Result), !.
pairs(_, []) :- !.

compose_line(Need-Fail, Line) :-
    format(string(Line), "For want of a ~w the ~w was lost.", [Need, Fail]).

closure_line(Need, Line) :-
    format(string(Line), "And all for the want of a ~w.", [Need]).

proverb([], []).
proverb(Needs, Verses) :-
    [First|_] = Needs,
    pairs(Needs, Pairs),
    maplist(compose_line, Pairs, BuildLines),
    closure_line(First, EndLine),
    append(BuildLines, [EndLine], Verses).
