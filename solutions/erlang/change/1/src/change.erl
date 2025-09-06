-module(change).
-export([find_fewest_coins/2]).

find_fewest_coins(Target, _Coins) when Target < 0 -> error("Cannot find negative change values");
find_fewest_coins(0, _Coins) -> [];

find_fewest_coins(Target, Coins) ->
    SortedCoins = lists:filter(fun(C)-> C =< Target end,
                               lists:reverse(
                                 lists:sort(Coins))),
    {_, _, Change} = find_fewest_coins(Target, SortedCoins, dict:new(), []),
    Change.

find_fewest_coins(0, _Coins, Table, Change) ->
    {1, Table, Change};
find_fewest_coins(Target, _Coins, Table, _Change) when Target < 0 ->
    {0, Table, undefined};
find_fewest_coins(_Target, [], Table, _Change) ->
    {0, Table, undefined};
find_fewest_coins(Target, [C|Cs]=Coins, Table, Change) ->
    case dict:is_key({Target, erlang:length(Coins)}, Table) of
        true ->
            {TargetRes, ChangeRes} = dict:fetch({Target, erlang:length(Coins)}, Table),
            {TargetRes, Table, ChangeRes};
        false ->
            {Target1, Table1, Change1} = find_fewest_coins(Target-C, Coins, Table, [C]++Change),
            {Target2, Table2, Change2} = find_fewest_coins(Target, Cs, Table1, Change),
            BestChange = find_best_change(Change1, Change2),
            {Target1+Target2,
             dict:store({Target, erlang:length(Coins)}, {Target1+Target2, BestChange}, Table2),
             BestChange}
    end.

find_best_change(Change1, Change2) ->
    if
        Change1 == undefined -> Change2;
        Change2 == undefined -> Change1;
        erlang:length(Change1) < erlang:length(Change2) -> Change1;
        true  -> Change2
    end.
