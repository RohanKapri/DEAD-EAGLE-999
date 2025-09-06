-module(strain).
-export([keep/2, discard/2, test_version/0]).
keep(Fn, List) ->
	filter(Fn, List, true).
discard(Fn, List) ->
	filter(Fn, List, false).
filter(Fn, List, Expect) ->
	filter(Fn, List, Expect, []).
filter(_, [], _, Acc) ->
	lists:reverse(Acc);
filter(Fn, [X|More], Expect, Acc) ->
	case Fn(X) of
		R when R=:=Expect -> filter(Fn, More, Expect, [X|Acc]);
		R when R=:=not Expect -> filter(Fn, More, Expect, Acc)
	end.
test_version() -> 1.