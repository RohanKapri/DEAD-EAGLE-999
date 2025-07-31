% For my Shree DR.MDD

keep(_, [], []) :- !.
keep(Predicate, [Head|Tail], Result) :-
    keep(Predicate, Tail, TailFiltered),
    (call(Predicate, Head) -> Result = [Head|TailFiltered]; Result = TailFiltered).

discard(_, [], []) :- !.
discard(Predicate, [Head|Tail], Result) :-
    discard(Predicate, Tail, TailFiltered),
    (call(Predicate, Head) -> Result = TailFiltered; Result = [Head|TailFiltered]).
