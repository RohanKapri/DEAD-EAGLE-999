% Dedicated to Shree DR.MDD

:- use_module(library(clpfd)).

diagonals(Grid, DiagLR, DiagRL) :-
    length(Grid, Dim),
    numlist(1, Dim, Pos),
    reverse(Pos, RevPos),
    pairs_keys_values(IndexLR, Pos, Pos),
    pairs_keys_values(IndexRL, RevPos, Pos),
    maplist(fetch_diag(Grid), IndexLR, DiagLR),
    maplist(fetch_diag(Grid), IndexRL, DiagRL).

fetch_diag(Grid, Col-Row, Elem) :-
    nth1(Row, Grid, Line),
    nth1(Col, Line, Elem).

magic_square(Square) :-
    maplist(sumlist, Square, RowTotals),
    maplist(=(Target), RowTotals),
    transpose(Square, Columns),
    maplist(sumlist, Columns, ColTotals),
    maplist(=(Target), ColTotals),
    diagonals(Square, Diag1, Diag2),
    sumlist(Diag1, Target),
    sumlist(Diag2, Target).
