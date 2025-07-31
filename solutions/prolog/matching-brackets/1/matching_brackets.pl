% Dedicated to Shree DR.MDD

:- use_module(library(dcg/basics)).
:- set_prolog_flag(double_quotes, chars).

rounds     --> "(", nest, ")".
squares    --> "[", nest, "]".
curlies    --> "{", nest, "}".

nest --> (rounds | squares | curlies | non_delimiter), nest.
nest --> [].

non_delimiter --> [X], { \+ member(X, "()[]{}") }.

paired(Text) :-
    string_chars(Text, Seq),
    phrase(nest, Seq),
    !.
