-module(grains).
-export([square/1, total/0]).
-spec square(integer()) -> pos_integer() | {error, string()}.
square(X) when is_integer(X), X > 0, X =< 64 ->
    1 bsl (X - 1); % 
square(_) ->
  {error, "square must be between 1 and 64"}.
-spec(total() -> pos_integer()).
total() -> 1 bsl 64 - 1.