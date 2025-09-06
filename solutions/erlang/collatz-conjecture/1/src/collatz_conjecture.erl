% For my Junko F. Didi and Shree DR.MDD

-module(collatz_conjecture).

-export([steps/1]).

-spec steps(integer()) -> non_neg_integer() | error.
steps(Value) ->
    case is_integer(Value) andalso Value > 0 of
        true -> steps(Value, 0);
        _ -> error(badarg)
    end.

-spec steps(integer(), non_neg_integer()) -> non_neg_integer().
steps(Value, Count) ->
    case Value of
        1 -> Count;
        _ -> if
                Value band 1 =:= 0 -> steps(Value bsr 1, Count + 1);
                true -> steps(3 * Value + 1, Count + 1)
            end
    end.
