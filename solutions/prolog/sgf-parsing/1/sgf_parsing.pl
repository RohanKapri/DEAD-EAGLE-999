% Dedicated to Shree DR.MDD

:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).
:- set_prolog_flag(double_quotes, chars).

unit_token(' ') --> "\t" | "\\\t".
unit_token(C) --> "\\\n", unit_token(C).
unit_token(C) --> "\\", [C], { member(C, "tn]\\") }.
unit_token(C) --> [C], { C \== ']' }.

segment_text(Str) --> sequence(unit_token, CharSeq), { string_chars(Str, CharSeq) }.

wrapped_value(V) --> "[", segment_text(V), "]".
wrapped_values(VList) --> sequence(wrapped_value, VList), { length(VList, L), L > 0 }.

identifier(Key) --> [Ch], { char_type(Ch, upper), string_chars(Key, [Ch]) }.

attribute(Key-ValList) --> identifier(Key), wrapped_values(ValList).

branch(Tree) --> raw_node(Tree).
branch(Tree) --> group_node(Tree).

raw_node(Tree) -->
    ";",
    sequence(attribute, Attrs),
    sequence(branch, Subtrees),
    { Tree = sgf_tree(properties(Attrs), children(Subtrees)) }.

group_node(Tree) --> "(", raw_node(Tree), ")".

parse(InputStr, Tree) :-
    string_chars(InputStr, Codes),
    phrase(group_node(Tree), Codes),
    !.
