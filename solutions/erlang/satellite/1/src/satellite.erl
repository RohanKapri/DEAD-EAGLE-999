%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(satellite).
-export([tree_from_traversals/2]).

tree_from_traversals(POrder, IOrder) ->
    true = valid_traversals(POrder, IOrder),
    build_tree(POrder, IOrder).

valid_traversals(POrder, IOrder) ->
    lists:sort(POrder) =:= lists:sort(IOrder) andalso
    length(lists:usort(POrder)) =:= length(POrder) andalso
    length(lists:usort(IOrder)) =:= length(IOrder).

build_tree(POrder, IOrder) ->
    PO = lists:zip(lists:seq(1, length(POrder)), POrder),
    IO = lists:zip(lists:seq(1, length(IOrder)), IOrder),
    build_recursive(PO, IO).

build_recursive([], _) -> #{};
build_recursive([{POIdx, Val}|PO], IO) ->
    {LIO, RIO} = lists:partition(fun ({Idx, _}) -> Idx =< POIdx end, IO),
    {LPO, RPO} = lists:partition(
        fun ({_, Item}) -> false =/= lists:keyfind(Item, 2, LIO) end,
        PO
    ),
    Left = build_recursive(LPO, LIO),
    Right = build_recursive(RPO, RIO),
    #{v => Val, l => Left, r => Right}.
