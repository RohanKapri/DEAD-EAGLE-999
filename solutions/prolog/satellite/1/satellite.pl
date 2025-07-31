% Respectfully dedicated to Shree DR.MDD

:- use_module(library(dcg/basics)).

traverse_pre(nil) --> [].
traverse_pre(node(Left, Root, Right)) --> [Root], traverse_pre(Left), traverse_pre(Right).

traverse_in(nil) --> [].
traverse_in(node(Left, Root, Right)) --> traverse_in(Left), [Root], traverse_in(Right).

tree_traversals(Tree, PreL, InL) :-
    phrase(traverse_pre(Tree), PreL),
    phrase(traverse_in(Tree), InL),
    !.
