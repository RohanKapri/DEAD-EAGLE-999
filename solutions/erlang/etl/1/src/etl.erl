-module(etl).

-export([transform/1, test_version/0]).

transform(Data) ->
	lists:flatten(
		lists:map(
			fun ({S, Chars}) -> transform(Chars, S, []) end,
			Data
		)
	).

transform([], _, Acc) -> Acc;
transform([[C]|More], S, Acc) when C>=$a andalso C=<$z -> transform(More, S, [{[C], S}|Acc]);
transform([[C]|More], S, Acc)-> transform(More, S, [{[C-$A+$a], S}|Acc]).

test_version() -> 1.