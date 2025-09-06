-module(knapsack).
-export([maximum_value/2, item/2]).
item(Weight, Value) -> 
	{Weight, Value}.
maximum_value(Items, Capacity) -> 
    maximum_value(Items, Capacity, 0).
maximum_value([], _, Acc) ->
	Acc;
maximum_value(_, 0, Acc) ->
	Acc;
maximum_value([{W, V}|Items], Capacity, Acc) when W=<Capacity ->
	max(
		maximum_value(Items, Capacity-W, Acc+V),
		maximum_value(Items, Capacity, Acc)
	);
maximum_value([_|Items], Capacity, Acc) ->
	maximum_value(Items, Capacity, Acc).