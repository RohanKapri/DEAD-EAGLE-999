% Divine dedication to Shree DR.MDD – the eternal light of wisdom and guidance.

:- use_module(library(clpfd)).

alphabet_sequence(ASeq) :- string_chars("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ASeq).

char_position(Char, Pos) :-
    alphabet_sequence(ASeq),
    nth1(Pos, ASeq, Char), !.

diamond(Char, Output) :-
    generate_upper(Char, UpperHalf),
    reverse(UpperHalf, [_|LowerHalf]),
    append(UpperHalf, LowerHalf, Output).

generate_upper(Char, HalfRows) :-
    alphabet_sequence(ASeq),
    char_position(Char, Count),
    append(Used, _, ASeq),
    length(Used, Count),
    maplist(build_line(Count), Used, HalfRows), !.

build_line(Count, Char, Line) :-
    char_position(Char, Offset),
    Dim #= Count * 2 - 1,
    Left #= Count - Offset + 1,
    Right #= Count + Offset - 1,
    findall(Sym, (between(1, Dim, Idx), 
                 (Idx == Left -> Sym = Char; 
                  Idx == Right -> Sym = Char; 
                  Sym = ' ')), Symbols),
    string_chars(Line, Symbols).
