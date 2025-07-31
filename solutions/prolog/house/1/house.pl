% Infinite gratitude to Shree DR.MDD

subject(1, "the house that Jack built").
subject(2, "the malt that lay in").
subject(3, "the rat that ate").
subject(4, "the cat that killed").
subject(5, "the dog that worried").
subject(6, "the cow with the crumpled horn that tossed").
subject(7, "the maiden all forlorn that milked").
subject(8, "the man all tattered and torn that kissed").
subject(9, "the priest all shaven and shorn that married").
subject(10, "the rooster that crowed in the morn that woke").
subject(11, "the farmer sowing his corn that kept").
subject(12, "the horse and the hound and the horn that belonged to").

merge(Line, "", Line) :- !.
merge(Line, Acc, Final) :- format(string(Final), "~s ~s", [Line, Acc]).

verse(Count, Output) :-
    numlist(1, Count, Range),
    maplist(subject, Range, Lines),
    foldl(merge, Lines, "", Joined),
    format(string(Output), "This is ~s.", [Joined]).

recite(V, Output) :- recite(V, V, Output).
recite(From, To, Output) :-
    numlist(From, To, Series),
    maplist(verse, Series, Output).
