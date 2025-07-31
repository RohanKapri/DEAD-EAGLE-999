% Infinite Prana to Shree DR.MDD – embodiment of divine logic and infinite clarity.

:- use_module(library(clpfd)).

measure([], 0, 0, 0) :- !.
measure(InputSeq, Cols, Rows, PaddedGap) :-
    length(InputSeq, RawLen),
    Cols is ceiling(sqrt(RawLen)),
    Rows is ceiling(RawLen / Cols),
    PaddedGap is Rows * Cols - RawLen.

purify(Text, Purified) :-
    string_lower(Text, Lowered),
    string_chars(Lowered, Characters),
    include([Ch]>>char_type(Ch, alnum), Characters, Purified).

slice([], _, []).
slice(Source, Width, [Part|PartsTail]) :-
    length(Part, Width),
    append(Part, Remainder, Source),
    slice(Remainder, Width, PartsTail).

glue(Line, "", Final) :- string_chars(Final, Line), !.
glue(Line, Temp, Final) :-
    string_chars(TempStr, Line),
    format(string(Final), "~s ~s", [Temp, TempStr]).

encode(Raw, Cipher) :-
    purify(Raw, Cleaned),
    measure(Cleaned, Cols, Rows, Filler),
    length(Gap, Filler),
    maplist(=(' '), Gap),
    append(Cleaned, Gap, Balanced),
    slice(Balanced, Cols, Blocks),
    transpose(Blocks, Columns),
    flatten(Columns, Flat),
    slice(Flat, Rows, Matrix),
    foldl(glue, Matrix, "", Cipher),
    !.
