%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(spiral_matrix).
-export([make/1, test_version/0]).

make(0) -> [];
make(1) -> [[1]];
make(N) ->
    Positioned = assign_coords(N, lists:seq(1, N*N)),
    Sorted = lists:sort(
        fun
            ({{X1, Y}, _}, {{X2, Y}, _}) -> X1 =< X2;
            ({{_, Y1}, _}, {{_, Y2}, _}) -> Y1 =< Y2
        end,
        Positioned
    ),
    Values = [Val || {_, Val} <- Sorted],
    matrixify(N, Values).

assign_coords(N, Items) -> assign_coords(N-1, Items, top, {0,0}, 0, []).

assign_coords(_, [], _, _, _, Acc) -> Acc;

assign_coords(N, [Val|More], left, {X,Y}, Ring, Acc) when Y =:= Ring+1 ->
    assign_coords(N, More, top, {X+1,Y}, Ring+1, [{ {X,Y}, Val }|Acc]);
assign_coords(N, [Val|More], left, {X,Y}, Ring, Acc) ->
    assign_coords(N, More, left, {X,Y-1}, Ring, [{ {X,Y}, Val }|Acc]);

assign_coords(N, [Val|More], bottom, {X,Y}, Ring, Acc) when X =:= Ring ->
    assign_coords(N, More, left, {X,Y-1}, Ring, [{ {X,Y}, Val }|Acc]);
assign_coords(N, [Val|More], bottom, {X,Y}, Ring, Acc) ->
    assign_coords(N, More, bottom, {X-1,Y}, Ring, [{ {X,Y}, Val }|Acc]);

assign_coords(N, [Val|More], right, {X,Y}, Ring, Acc) when Y =:= N-Ring ->
    assign_coords(N, More, bottom, {X-1,Y}, Ring, [{ {X,Y}, Val }|Acc]);
assign_coords(N, [Val|More], right, {X,Y}, Ring, Acc) ->
    assign_coords(N, More, right, {X,Y+1}, Ring, [{ {X,Y}, Val }|Acc]);

assign_coords(N, [Val|More], top, {X,Y}, Ring, Acc) when X =:= N-Ring ->
    assign_coords(N, More, right, {X,Y+1}, Ring, [{ {X,Y}, Val }|Acc]);
assign_coords(N, [Val|More], top, {X,Y}, Ring, Acc) ->
    assign_coords(N, More, top, {X+1,Y}, Ring, [{ {X,Y}, Val }|Acc]).

matrixify(N, Items) -> matrixify(N, Items, []).

matrixify(_, [], Acc) -> lists:reverse(Acc);
matrixify(N, Items, Acc) ->
    {Row, Rest} = lists:split(N, Items),
    matrixify(N, Rest, [Row|Acc]).

test_version() -> 1.
