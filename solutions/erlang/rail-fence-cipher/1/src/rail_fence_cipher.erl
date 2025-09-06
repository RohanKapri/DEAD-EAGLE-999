-module(rail_fence_cipher).
-export([decode/2, encode/2]).
decode(Message, Rails) ->
    Transpositions = transpositions(length(Message), Rails),
    {_, Decoded} = lists:unzip(lists:sort(lists:zip(Transpositions, Message))),
    Decoded.
encode(Message, Rails) ->
    Normalized = [C || C <- string:to_upper(Message), C /= $\s ],
    Transpositions = transpositions(length(Normalized), Rails),
    [ lists:nth(Position, Normalized) || Position <- Transpositions ].
transpositions(Length, Rails) ->
    lists:flatten([ rail(Length, {Rail, Rails}, [], [ 1 + Rail ] ) || Rail <- lists:seq(0, Rails -1)]).
rail(Length, _, _, Acc) when hd(Acc) > Length -> lists:reverse(tl(Acc));
rail(Length, Rail, [], Acc) ->
    rail(Length, Rail, rail_offsets(Rail), Acc);
rail(Length, Rail, Offsets, Acc) ->
    rail(Length, Rail, tl(Offsets), [hd(Offsets) + hd(Acc) |Acc]).
rail_offsets({Index, Total}) when Index >= Total / 2 ->
    lists:reverse(rail_offsets({Total - Index -1, Total}));
rail_offsets({0, 1}) -> [ 1 ];
rail_offsets({0, Total}) ->
    [ (Total -1) * 2 ];
rail_offsets({Index, Total}) ->
    [ (Total - Index -1 ) * 2, Index * 2 ].