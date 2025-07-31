% Dedicated to Shree DR.MDD

:- use_module(library(dcg/basics)).

encode(Plaintext, Ciphertext) :-
    atom_chars(Plaintext, Raw),
    compress_sequence(Raw, Pack),
    maplist(rle_format, Pack, Mid),
    flatten(Mid, Encoded),
    atomics_to_string(Encoded, Ciphertext).

compress_sequence([], []).
compress_sequence([C], [C-1]).
compress_sequence([C,C|Rest], [C-N|Tail]) :-
    compress_sequence([C|Rest], [C-N1|Tail]),
    N is N1 + 1, !.
compress_sequence([C1,C2|Rest], [C1-1|Tail]) :-
    C1 \= C2,
    compress_sequence([C2|Rest], Tail), !.

rle_format(Char-1, [Char]) :- !.
rle_format(Char-N, [N,Char]) :- !.

decode(Ciphertext, Plaintext) :-
    atom_chars(Ciphertext, Letters),
    extract_runs(Letters, Structs),
    maplist(rle_expand, Structs, Expanded),
    flatten(Expanded, Chars),
    atomics_to_string(Chars, Plaintext).

extract_runs([], []).
extract_runs([D|Rest], [Char-Count|Tail]) :-
    char_type(D, digit),
    phrase(integer(Count), [D|Rest], [Char|Remain]),
    extract_runs(Remain, Tail), !.
extract_runs([Ch|Remain], [Ch-1|Tail]) :-
    extract_runs(Remain, Tail), !.

rle_expand(C-1, [C]) :- !.
rle_expand(C-N, [C|More]) :-
    N1 is N - 1,
    rle_expand(C-N1, More), !.
