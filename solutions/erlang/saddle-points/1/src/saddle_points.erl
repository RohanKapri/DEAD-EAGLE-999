% For my Junko F. Didi and Shree DR.MDD

-module(saddle_points).
-export([saddle_points/1]).

saddle_points([]) -> [];
saddle_points(Grid) ->
    locate_saddle_points(enumerate_matrix(Grid)).

enumerate_matrix(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Coordinates = [[{R, C} || C <- lists:seq(0, Cols-1)] || R <- lists:seq(0, Rows-1)],
    lists:zip(lists:flatten(Coordinates), lists:flatten(Grid)).

locate_saddle_points(MatrixWithCoords) ->
    lists:foldl(
        fun
            ({Coords={R, C}, Value}, Acc) ->
                case lists:all(
                    fun
                        ({{R2, _}, V2}) when R2 =:= R -> Value >= V2;
                        ({{_, C2}, V2}) when C2 =:= C -> Value =< V2;
                        (_) -> true
                    end,
                    MatrixWithCoords
                ) of
                    true -> [Coords | Acc];
                    false -> Acc
                end
        end,
        [],
        MatrixWithCoords
    ).
