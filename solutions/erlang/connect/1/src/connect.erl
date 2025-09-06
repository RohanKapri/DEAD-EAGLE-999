%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(connect).

-export([winner/1]).

winner(BoardInput) ->
    determine_winner(group_cells(parse_board(BoardInput))).

parse_board(BoardInput) ->
    maps:from_list(
        lists:filter(
            fun
                ({_, empty}) -> false;
                (_) -> true
            end,
            parse_board(BoardInput, 0, [])
        )
    ).

parse_board([Row], RowIndex, []) ->
    parse_row(Row, top_bottom, RowIndex);
parse_board([Row|More], RowIndex, []) ->
    parse_board(More, RowIndex+1, [parse_row(Row, top, RowIndex)]);
parse_board([Row], RowIndex, Acc) ->
    lists:flatten([parse_row(Row, bottom, RowIndex)|Acc]);
parse_board([Row|More], RowIndex, Acc) ->
    parse_board(More, RowIndex+1, [parse_row(Row, inner, RowIndex)|Acc]).

parse_row(Row, Tag, RowIndex) ->
    parse_row(Row, Tag, RowIndex, 0, []).

parse_row([], _, _, _, Acc) -> Acc;
parse_row([16#20|Rest], Tag, RowIndex, ColIndex, Acc) ->
    parse_row(Rest, Tag, RowIndex, ColIndex+1, Acc);
parse_row([$.|Rest], Tag, RowIndex, ColIndex, Acc) ->
    parse_row(Rest, Tag, RowIndex, ColIndex+1, [{{ColIndex, RowIndex}, empty}|Acc]);
parse_row([$X], Tag, RowIndex, ColIndex, []) ->
    [{{ColIndex, RowIndex}, {x, {ColIndex, RowIndex}, {left_right, Tag}}}];
parse_row([$X|Rest], Tag, RowIndex, ColIndex, []) ->
    parse_row(Rest, Tag, RowIndex, ColIndex+1, [{{ColIndex, RowIndex}, {x, {ColIndex, RowIndex}, {left, Tag}}}]);
parse_row([$X], Tag, RowIndex, ColIndex, Acc) ->
    [{{ColIndex, RowIndex}, {x, {ColIndex, RowIndex}, {right, Tag}}}|Acc];
parse_row([$X|Rest], Tag, RowIndex, ColIndex, Acc) ->
    parse_row(Rest, Tag, RowIndex, ColIndex+1, [{{ColIndex, RowIndex}, {x, {ColIndex, RowIndex}, {inner, Tag}}}|Acc]);
parse_row([$O], Tag, RowIndex, ColIndex, []) ->
    [{{ColIndex, RowIndex}, {o, {ColIndex, RowIndex}, {left_right, Tag}}}];
parse_row([$O|Rest], Tag, RowIndex, ColIndex, []) ->
    parse_row(Rest, Tag, RowIndex, ColIndex+1, [{{ColIndex, RowIndex}, {o, {ColIndex, RowIndex}, {left, Tag}}}]);
parse_row([$O], Tag, RowIndex, ColIndex, Acc) ->
    [{{ColIndex, RowIndex}, {o, {ColIndex, RowIndex}, {right, Tag}}}|Acc];
parse_row([$O|Rest], Tag, RowIndex, ColIndex, Acc) ->
    parse_row(Rest, Tag, RowIndex, ColIndex+1, [{{ColIndex, RowIndex}, {o, {ColIndex, RowIndex}, {inner, Tag}}}|Acc]).

get_adjacent({X, Y}, Player, BoardMap) ->
    maps:filter(
        fun
            (_, {P, _, _}) when P=/=Player -> false;
            ({X2, Y2}, _) when X2=:=X-2 andalso Y2=:=Y -> true;
            ({X2, Y2}, _) when X2=:=X+2 andalso Y2=:=Y -> true;
            ({X2, Y2}, _) when X2=:=X+1 andalso Y2=:=Y-1 -> true;
            ({X2, Y2}, _) when X2=:=X-1 andalso Y2=:=Y-1 -> true;
            ({X2, Y2}, _) when X2=:=X+1 andalso Y2=:=Y+1 -> true;
            ({X2, Y2}, _) when X2=:=X-1 andalso Y2=:=Y+1 -> true;
            (_, _) -> false
        end,
        BoardMap
    ).

group_cells(BoardMap) ->
    group_cells(maps:to_list(BoardMap), BoardMap).

group_cells([], BoardMap) ->
    maps:fold(
        fun
            (_, {_, _, {inner, inner}}, Acc) -> Acc;
            (_, {P, G, Tag}, Acc) -> Acc#{{P, G} => [Tag|maps:get({P, G}, Acc, [])]}
        end,
        #{},
        BoardMap
    );
group_cells([{Coords, {Player, Group, _}}|More], BoardMap) ->
    Adj=get_adjacent(Coords, Player, BoardMap),
    UpdatedBoard =
        maps:fold(
            fun
                (_, {_, G2, _}, Acc) when G2=:=Group -> Acc;
                (_, {_, G2, _}, Acc) ->
                    maps:map(
                        fun
                            (_, {P3, G3, Tag3}) when G3=:=G2 -> {P3, Group, Tag3};
                            (_, V3) -> V3
                        end,
                        Acc
                    )
            end,
            BoardMap,
            Adj
        ),
    group_cells(More, UpdatedBoard).

determine_winner(Groups) ->
    maps:fold(
        fun
            ({o, _}, Tags, undefined) ->
                case lists:foldl(
                        fun
                            (_, {true, true}) -> {true, true};
                            ({_, top}, {_, Acc2}) -> {true, Acc2};
                            ({_, bottom}, {Acc1, _}) -> {Acc1, true};
                            ({_, top_bottom}, _) -> {true, true};
                            (_, Acc) -> Acc
                        end,
                        {false, false},
                        Tags
                    ) of
                    {true, true} -> o;
                    _ -> undefined
                end;
            ({x, _}, Tags, undefined) ->
                case lists:foldl(
                        fun
                            (_, {true, true}) -> {true, true};
                            ({left, _}, {_, Acc2}) -> {true, Acc2};
                            ({right, _}, {Acc1, _}) -> {Acc1, true};
                            ({left_right, _}, _) -> {true, true};
                            (_, Acc) -> Acc
                        end,
                        {false, false},
                        Tags
                    ) of
                    {true, true} -> x;
                    _ -> undefined
                end;
            (_, _, Acc) -> Acc
        end,
        undefined,
        Groups
    ).
