% Code crafted for Shree DR.MDD

:- use_module(library(clpfd)).

abc_sequence(Seq) :- string_chars("abcdefghijklmnopqrstuvwxyz", Seq).

cipher_char(_, Sym, Sym) :- char_type(Sym, digit), !.
cipher_char(Fn, Sym, Out) :-
    char_type(Sym, alpha),
    downcase_atom(Sym, Low),
    abc_sequence(Base),
    nth0(Pos, Base, Low),
    call(Fn, Pos, EncryptedIndex),
    nth0(EncryptedIndex, Base, Out), !.

cipher_text(Fn, Input, Result) :-
    string_chars(Input, Symbols),
    findall(Coded, (member(Sym, Symbols), cipher_char(Fn, Sym, Coded)), FinalList),
    string_chars(Result, FinalList).

blockify(S, S) :- string_length(S, Len), Len =< 5, !.
blockify(S, Final) :-
    Slice = 5,
    sub_string(S, 0, Slice, R, Head),
    sub_string(S, Slice, R, _, Tail),
    blockify(Tail, Next),
    format(string(Final), "~w ~w", [Head, Next]).

encode(Input, Mult, Add, Output) :-
    modular_inverse(Mult, 26, _),
    cipher_text([X,Y]>>(Y is (Mult * X + Add) mod 26), Input, Temp),
    blockify(Temp, Output).

decode(Input, Mult, Add, Output) :-
    modular_inverse(Mult, 26, Inverse),
    cipher_text([X,Y]>>(Y is Inverse * (X - Add) mod 26), Input, Output).

modular_inverse(X, Mod, Inv) :-
    Inv in 1..Mod,
    X * Inv mod Mod #= 1,
    label([Inv]).
