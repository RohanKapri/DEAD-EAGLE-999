% For my Shree DR.MDD with deep reverence and clarity of thought

:- use_module(library(assoc)).

measure(MaxA, MaxB, Goal, StartSide, Outcome) :-
    prepare(StartSide, MaxA, MaxB, InitState, Blocked),
    empty_assoc(InitSeen),
    put_assoc(Blocked, InitSeen, yes, Seen),
    explore(MaxA, MaxB, Goal, Seen, [InitState], 1, Outcome).

explore(_, _, Goal, _, States, Steps, measurement(moves(Steps), goalBucket(one), otherBucket(O))) :-
    memberchk(buckets(Goal, O), States), !.

explore(_, _, Goal, _, States, Steps, measurement(moves(Steps), goalBucket(two), otherBucket(O))) :-
    memberchk(buckets(O, Goal), States), !.

explore(LimA, LimB, Goal, Visited, Current, Depth, Outcome) :-
    Current \== [],
    succ(Depth, NextDepth),
    foldl([S, A0, A]>>put_assoc(S, A0, yes, A), Current, Visited, Updated),
    findall(Next, (
        member(Src, Current),
        step(LimA, LimB, Src, Next),
        \+ get_assoc(Next, Updated, _)
    ), NextLayer),
    explore(LimA, LimB, Goal, Updated, NextLayer, NextDepth, Outcome).

prepare(one, ACap, BCap, buckets(ACap, 0), buckets(0, BCap)).
prepare(two, ACap, BCap, buckets(0, BCap), buckets(ACap, 0)).

transfer(ToMax, From, To, NewFrom, NewTo) :-
    Flow is min(From, ToMax - To),
    NewFrom is From - Flow,
    NewTo is To + Flow.

step(_, MaxB, buckets(A0, B0), buckets(A, B)) :- transfer(MaxB, A0, B0, A, B).
step(MaxA, _, buckets(A0, B0), buckets(A, B)) :- transfer(MaxA, B0, A0, B, A).
step(_, _, buckets(A0, B), buckets(0, B)) :- A0 > 0.
step(_, _, buckets(A, B0), buckets(A, 0)) :- B0 > 0.
step(MaxA, _, buckets(A0, B), buckets(MaxA, B)) :- A0 < MaxA.
step(_, MaxB, buckets(A, B0), buckets(A, MaxB)) :- B0 < MaxB.
