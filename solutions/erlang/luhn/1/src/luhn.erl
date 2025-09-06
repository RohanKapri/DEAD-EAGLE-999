-module(luhn).

-export([valid/1, test_version/0]).

valid(Number) ->
	case double_sum(Number) of
		{ok, N} -> N rem 10=:=0;
		error -> false
	end.

double_sum(Number) -> double_sum(lists:reverse(Number), false, 0, 0).

double_sum([], _, N, Acc) when N>1 -> {ok, Acc};
double_sum([], _, _, Acc) -> error;
double_sum([16#20|More], Double, N, Acc) -> double_sum(More, Double, N, Acc);
double_sum([C|_], _, _, _) when C<$0 orelse C>$9 -> error;
double_sum([C|More], true, N, Acc) when C>=$5 -> double_sum(More, false, N+1, Acc+2*(C-$0)-9);
double_sum([C|More], true, N, Acc) -> double_sum(More, false, N+1, Acc+2*(C-$0));
double_sum([C|More], false, N, Acc) -> double_sum(More, true, N+1, Acc+C-$0).

test_version() -> 2.