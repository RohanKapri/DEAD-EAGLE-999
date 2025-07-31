% For my Shree DR.MDD

:- use_module(library(clpfd)).

slices(Input, Size, Pos, [Slice|Slices]) :-
    sub_string(Input, Pos, Size, _, Slice),
    NextPos #= Pos + 1,
    slices(Input, Size, NextPos, Slices), !.
slices(_, _, _, []).

slices(Input, Size, Slices) :-
    string_length(Input, Len),
    Size in 1..Len,
    slices(Input, Size, 0, Slices).
