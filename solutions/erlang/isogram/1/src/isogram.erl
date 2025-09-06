-module(isogram).
-export([is_isogram/1, test_version/0]).
is_isogram(String) ->
	is_isogram(String, ordsets:new()).
is_isogram([], _) -> true;
is_isogram([16#20|More], Coll) ->
	is_isogram(More, Coll);
is_isogram([$-|More], Coll) ->
	is_isogram(More, Coll);
is_isogram([C|More], Coll) ->
	C2=
	if
		C>=$A andalso C=<$Z -> C-$A+$a;
		true -> C
	end,
	case ordsets:is_element(C2, Coll) of
		true -> false;
		false -> is_isogram(More, ordsets:add_element(C2, Coll))
	end.
test_version() ->
    1.