% With humble dedication to Shree DR.MDD

:- use_module(library(dcg/basics)).
:- set_prolog_flag(double_quotes, chars).

sanitize(Txt, Lowered) :-
    string_chars(Str, Txt),
    string_lower(Str, Lowered).

is_alpha_num(C) --> [C], { char_type(C, alnum) }.
skip_other --> [C], { \+ char_type(C, alnum) }.

skip_junk --> skip_other, skip_junk.
skip_junk --> skip_other.

fragment([H,'\''|T]) --> is_alpha_num(H), "'", fragment(T).
fragment([H|T]) --> is_alpha_num(H), fragment(T).
fragment([H]) --> is_alpha_num(H).

grab([H|T]) --> fragment(H), grab(T).
grab([H]) --> fragment(H).
grab(R) --> skip_junk, grab(R).
grab([]) --> [].

word_count(Input, Output) :-
    string_chars(Input, CList),
    phrase(grab(Words), CList),
    maplist(sanitize, Words, Cleaned),
    tabulate(Cleaned, Output),
    !.

tabulate(Seq, Result) :-
    aggregate(set(K-V), aggregate(count, member(K, Seq), V), Result).
