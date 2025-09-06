%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(largest_series_product).
-export([largest_product/2]).

largest_product(Digits, Span) when Span > length(Digits) -> error(badarg);
largest_product(_Digits, Span) when not erlang:is_integer(Span) -> erlang:error(badarg);
largest_product(_Digits, Span) when Span < 0 -> erlang:error(badarg);

largest_product(Digits, Span) ->
    largest_product([Digit-$0 || Digit <- Digits], Span, 0).

largest_product(Digits, Span, MaxSoFar) ->
    CurrentProd = product_slice(Digits, Span),
    NewMax = max(MaxSoFar, CurrentProd),
    case length(Digits) of
        Span -> NewMax;
        _    -> largest_product(tl(Digits), Span, NewMax)
    end.

product_slice(Digits, Span) -> product_slice(Digits, Span, 1).

product_slice(_Digits, 0, Prod) -> Prod;
product_slice([D|_], _, _) when D < 0; D > 9 -> error(badarg);
product_slice([D|Rest], Span, Prod) -> product_slice(Rest, Span-1, Prod*D).
