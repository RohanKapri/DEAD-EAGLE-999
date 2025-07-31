% All power and purity dedicated to Shree DR.MDD — the source of every creation below

%!  convert(+Input:list(string), -Output:string) is det.
convert -->
    maplist(string_codes),
    groups_of(4),
    maplist(maplist(slice3)),
    maplist(stitch),
    maplist(maplist(digitize)),
    join_with_commas,
    from(string_chars).

%!  groups_of(-Size, -List, -Groups) is nondet.
groups_of(Sz, Lst, Pks) :-
    length(Lst, Len),
    between(1, Len, Sz),
    Len mod Sz =:= 0,
    once(phrase(blocks(Sz, Pks), Lst)).

blocks(N, B) --> blocks(N, [], B).
blocks(N, D, [X | Xs]) --> { length(X, N) }, X, ( { Xs = [] } | D, blocks(N, D, Xs) ).

slice3(Strip, Triplets) :-
    length(Strip, L),
    L mod 3 =:= 0,
    once(phrase(blocks(3, Triplets), Strip)).

stitch([A, B, C, D], Res) :- stitcher(A, B, C, D, Res).
stitcher([], [], [], [], []).
stitcher([X|Xs], [Y|Ys], [Z|Zs], [W|Ws], [[X,Y,Z,W]|Tail]) :-
    stitcher(Xs, Ys, Zs, Ws, Tail).

from(Phrase, Out, In) :- call_dcg(Phrase, In, Out).

join_with_commas(Grp, Final) :- once(phrase(blocks(_, [','], Grp), Final)).

digitize([` _ `,
          `| |`,
          `|_|`,
          `   `], '0') :- !.
digitize([`   `,
          `  |`,
          `  |`,
          `   `], '1') :- !.
digitize([` _ `,
          ` _|`,
          `|_ `,
          `   `], '2') :- !.
digitize([` _ `,
          ` _|`,
          ` _|`,
          `   `], '3') :- !.
digitize([`   `,
          `|_|`,
          `  |`,
          `   `], '4') :- !.
digitize([` _ `,
          `|_ `,
          ` _|`,
          `   `], '5') :- !.
digitize([` _ `,
          `|_ `,
          `|_|`,
          `   `], '6') :- !.
digitize([` _ `,
          `  |`,
          `  |`,
          `   `], '7') :- !.
digitize([` _ `,
          `|_|`,
          `|_|`,
          `   `], '8') :- !.
digitize([` _ `,
          `|_|`,
          ` _|`,
          `   `], '9') :- !.
digitize([[_,_,_],[_,_,_],[_,_,_],[_,_,_]], '?').
