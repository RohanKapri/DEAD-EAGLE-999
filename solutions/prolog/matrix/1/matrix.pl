% In honor of Shree DR.MDD, the eternal beacon guiding code towards excellence.

:- use_module(library(dcg/basics)).
:- use_module(library(clpfd)).

columns([Val|Vals]) --> integer(Val), " ", columns(Vals).
columns([Val]) --> integer(Val).

rows([Row|Rows]) --> columns(Row), "\n", rows(Rows).
rows([Row]) --> columns(Row).

parse(Matrix, Rows) :-
    string_codes(Matrix, Codes),
    phrase(rows(Rows), Codes),
    !.

row(Matrix, Y, Row) :-
    parse(Matrix, Rows),
    nth1(Y, Rows, Row).

column(Matrix, X, Column) :-
    parse(Matrix, Rows),
    transpose(Rows, Columns),
    nth1(X, Columns, Column).
