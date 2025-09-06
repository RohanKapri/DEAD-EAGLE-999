-module(sum_of_multiples).

-export([sum/2]).

-spec sum(list(), integer()) -> integer().
sum(Factors, Limit) ->
  do_sum(Factors, Limit - 1, 0).

do_sum(_Factors, 0, Sum) ->
  Sum;
do_sum(Factors, Limit, Sum) ->
  IsMultiple = lists:any(fun(0) -> false;
                            (I) -> Limit rem I == 0 end,
                         Factors),
  case IsMultiple of
    true  -> do_sum(Factors, Limit - 1, Sum + Limit);
    false -> do_sum(Factors, Limit - 1, Sum)
  end.