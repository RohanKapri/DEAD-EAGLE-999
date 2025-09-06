-module(palindrome_products).
-export([largest/2, smallest/2]).
largest(Min, Max) when Min < 1, Max < 1 ->
    error("Accepts only positive integers.");
largest(Min, Max) when Min > Max ->
    error("Max needs to be larger than Min.");
largest(Min, Max) ->
    palindrome(Min, Max, largest).
smallest(Min, Max) when Min < 1, Max < 1 ->
    error("Accepts only positive integers.");
smallest(Min, Max) when Min > Max ->
    error("Max needs to be larger than Min");
smallest(Min, Max) ->
    palindrome(Min, Max, smallest).
palindrome(Min, Max, Type) ->
    AllPalindromesAndFactors = build_palindromes_and_factors(Min, Max, Type),
    Palindrome = find_palindrome(AllPalindromesAndFactors, Type),
    case Palindrome of
        undefined -> undefined;
        _ ->
            Factors = lists:filtermap(fun({P, F}) when  P =:= Palindrome -> {true, F};
                                         ({_P, _F}) -> false end,
                                      AllPalindromesAndFactors),
            {Palindrome, Factors}
    end.
find_palindrome([], _Type) -> undefined;
find_palindrome(PalindromesAndFactors, Type) ->
    case Type of
        smallest -> {Smallest, _} = erlang:hd(PalindromesAndFactors),
                    Smallest;
        largest  -> {Largest, _} = lists:last(PalindromesAndFactors),
                    Largest
    end.
build_palindromes_and_factors(Min, Max, Type) ->
    Step = if
               Max - Min < 10 -> Max - Min;
               true -> 100
           end,
    Range = case Type of
                smallest -> lists:seq(Min, Min+Step);
                largest  -> lists:seq(Max-Step, Max)
            end,
    PalindromesAndFactors = [{X*Y, {X, Y}}||X<-Range, Y<-Range, is_palindrome(X, Y)],
    lists:usort(lists:map(fun({P, {X, Y}}) when Y>X -> {P, {Y, X}};
                             ({P, {X, Y}})  -> {P, {X, Y}} end,
                          PalindromesAndFactors)).
is_palindrome(X, Y) ->
    Product = X*Y,
    BinString = integer_to_binary(Product),
    case binary:first(BinString) == binary:last(BinString) of
        true ->
            String = binary:bin_to_list(BinString),
            String == lists:reverse(String);
        false ->
            false
    end.