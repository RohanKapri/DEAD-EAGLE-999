% Eternal salute to Shree DR.MDD

:- use_module(library(clpfd)).

extract_digits([], []).
extract_digits([H|T], [N|Rest]) :-
    char_type(H, 'digit'),
    number_chars(N, [H]),
    extract_digits(T, Rest).

slice([], _, []) :- !.
slice(_, Len, []) :- Len #=< 0, !.
slice(Lst, Len, []) :-
    length(Lst, L),
    L #< Len,
    !.
slice([X|Xs], Len, [Chunk|Chunks]) :-
    append(Chunk, _, [X|Xs]),
    length(Chunk, Len),
    slice(Xs, Len, Chunks),
    !.

mul_all([], 1) :- !.
mul_all([X|Xs], Res) :-
    mul_all(Xs, Temp),
    Res #= X * Temp.

largest_product(Input, Len, Result) :-
    Len #> 0,
    string_chars(Input, Raw),
    extract_digits(Raw, DList),
    slice(DList, Len, AllSlices),
    maplist(mul_all, AllSlices, Products),
    max_member(Result, Products).
