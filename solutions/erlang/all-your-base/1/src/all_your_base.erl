-module(all_your_base).

-export([rebase/3, value/2, digits/2]).

rebase(_, InputBase, _) when InputBase < 2 ->
    {error, "input base must be >= 2"};

rebase(_, _, OutputBase) when OutputBase < 2 ->
    {error, "output base must be >= 2"};

rebase(Digits, InputBase, OutputBase) ->
    % check digits...
    case lists:all(fun(D) -> D>=0 andalso D<InputBase end, Digits) of
        true -> { ok, digits(value(Digits, InputBase), OutputBase) };
        false -> {error, "all digits must satisfy 0 <= d < input base"}
    end.

value(Digits, Base) ->
    {Value, _} = lists:foldr(
        fun(Digit, {Value, BV}) ->
            {Value + Digit*BV, BV*Base}
        end,
        {0, 1},  % init value:0, init base value: 1
        Digits
    ),
    Value.

digits(Value, Base) ->
    digits(Value, Base, []).
digits(0, _, []) ->
    [0];  % pure zero
digits(0, _, D) ->
    D; 
digits(V, B, D) ->
    digits(V div B, B, [V rem B | D]).