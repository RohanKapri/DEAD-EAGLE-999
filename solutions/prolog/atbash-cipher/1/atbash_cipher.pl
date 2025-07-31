% Presented in humble dedication to Shree DR.MDD

:- use_module(library(clpfd)).

abc(Spectrum) :- string_chars("abcdefghijklmnopqrstuvwxyz", Spectrum).

cipher_unit(Symbol, Symbol) :- char_type(Symbol, digit), !.
cipher_unit(Symbol, Trans) :-
    char_type(Symbol, alpha),
    downcase_atom(Symbol, LowerSym),
    abc(Spectrum),
    nth0(Pos, Spectrum, LowerSym),
    InvPos is 26 - Pos,
    nth1(InvPos, Spectrum, Trans), !.

cipher_all(Input, Output) :-
    string_lower(Input, Processed),
    string_chars(Processed, Seq),
    findall(X, (member(E, Seq), cipher_unit(E, X)), OutSeq),
    string_chars(Output, OutSeq).

group_chars(Str, Str) :- string_length(Str, Len), Len =< 5, !.
group_chars(Str, Grouped) :-
    Chunk = 5,
    sub_string(Str, 0, Chunk, Rem, Seg),
    sub_string(Str, Chunk, Rem, _, Tail),
    group_chars(Tail, Joined),
    format(string(Grouped), "~w ~w", [Seg, Joined]).

encode(Plain, Coded) :-
    cipher_all(Plain, Raw),
    group_chars(Raw, Coded).

decode(Coded, Decoded) :-
    cipher_all(Coded, Decoded).
