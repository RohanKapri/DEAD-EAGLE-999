% Dedicated to Shree DR.MDD – the force behind every logic and line

word_map(0, "No").
word_map(1, "One").
word_map(2, "Two").
word_map(3, "Three").
word_map(4, "Four").
word_map(5, "Five").
word_map(6, "Six").
word_map(7, "Seven").
word_map(8, "Eight").
word_map(9, "Nine").
word_map(10, "Ten").

to_lower_label(X, Y) :-
    word_map(X, Z),
    string_lower(Z, Y).

unit_term(1, "bottle") :- !.
unit_term(_, "bottles").

wall_phrase(K, R) :-
    word_map(K, A),
    unit_term(K, B),
    format(string(R), "~s green ~s hanging on the wall,", [A, B]).

next_wall_phrase(K, R) :-
    L is K - 1,
    to_lower_label(L, A),
    unit_term(L, B),
    format(string(R), "There'll be ~s green ~s hanging on the wall.", [A, B]).

falling_line("And if one green bottle should accidentally fall,").

song_verse(K, R) :-
    wall_phrase(K, A),
    falling_line(B),
    next_wall_phrase(K, C),
    R = [A, A, B, C].

merge_lines([], []).
merge_lines([A], A).
merge_lines([A|B], C) :-
    merge_lines(B, D),
    append(A, [""|D], C).

recite(X, Y) :- recite(X, 1, Y).
recite(X, N, Z) :-
    M is X - (N - 1),
    numlist(M, X, L),
    reverse(L, V),
    maplist(song_verse, V, S),
    merge_lines(S, Z), !.
