-module(raindrops).

-export([convert/1, test_version/0]).

convert(Number) when is_integer(Number) -> convert(Number, [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}], "").

convert(N, [], []) -> integer_to_list(N);

convert(_, [], Acc) -> Acc;

convert(N, [{F, Sound}|More], Acc) when N rem F=:=0 -> convert(N, More, Acc++Sound);

convert(N, [_|More], Acc) -> convert(N, More, Acc).

test_version() -> 1.