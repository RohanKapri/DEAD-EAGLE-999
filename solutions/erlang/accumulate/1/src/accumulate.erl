-module(accumulate).

-export([accumulate/2, test_version/0]).

accumulate(Fn, Ls) when is_function(Fn, 1) andalso is_list(Ls) -> accumulate(Fn, Ls, []).

accumulate(_, [], Acc) -> lists:reverse(Acc);

accumulate(Fn, [X|Xs], Acc) -> accumulate(Fn, Xs, [Fn(X)|Acc]).

test_version() -> 1.