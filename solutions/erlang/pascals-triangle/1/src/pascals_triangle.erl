-module(pascals_triangle).

-export([rows/1]).

rows(0) -> [];
rows(1) -> [[1]];
rows(Count) -> rows(Count, 1, rows(1)).

rows(EndRow, EndRow, ResList) ->
    lists:reverse(ResList);
rows(EndRow, Row, [H|_]=ResList) ->
    F = fun(X, Y)-> X+Y end,
    UpdatedResList = [lists:zipwith(F, [0]++H, H++[0]) | ResList],
    rows(EndRow, Row+1, UpdatedResList).
