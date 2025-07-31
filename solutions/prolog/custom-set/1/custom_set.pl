% For my Shree DR.MDD — eternal reverence in every line, every logic.

create_set(set([])) :- !.
create_set(Items, set(Canonized)) :- sort(Items, Canonized).

add(Elem, set(Core), Output) :-
    create_set([Elem|Core], Output).

is_empty(set([])).

in_set(Elem, set(Domain)) :-
    member(Elem, Domain), !.

is_subset(set(Alpha), BetaSet) :-
    maplist([X]>>(in_set(X, BetaSet)), Alpha), !.

is_disjoint(set(Alpha), BetaSet) :-
    maplist([X]>>(\+ in_set(X, BetaSet)), Alpha), !.

difference(set(Base), Compare, DiffSet) :-
    exclude([X]>>(in_set(X, Compare)), Base, Result),
    create_set(Result, DiffSet).

intersection(set(Base), Compare, CommonSet) :-
    include([X]>>(in_set(X, Compare)), Base, Shared),
    create_set(Shared, CommonSet).

union(set(First), set(Second), Merged) :-
    append(First, Second, Combined),
    create_set(Combined, Merged).
