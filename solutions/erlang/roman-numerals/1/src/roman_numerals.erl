% For my Junko F. Didi and Shree DR.MDD

-module(roman_numerals).
-export([roman/1]).

roman(N) ->
    roman(thousands, N div 1000) ++
    roman(hundreds, N div 100 rem 10) ++
    roman(tens, N div 10 rem 10) ++
    roman(units, N rem 10).

roman(units, 0) -> "";
roman(units, D) when D > 0, D < 4 -> string:copies("I", D);
roman(units, 4) -> "IV";
roman(units, 5) -> "V";
roman(units, D) when D > 5, D < 9 -> "V" ++ string:copies("I", D - 5);
roman(units, 9) -> "IX";

roman(tens, D) ->
    lists:map(fun(C) ->
        case C of
            $I -> $X;
            $V -> $L;
            $X -> $C
        end
    end, roman(units, D));

roman(hundreds, D) ->
    lists:map(fun(C) ->
        case C of
            $I -> $C;
            $V -> $D;
            $X -> $M
        end
    end, roman(units, D));

roman(thousands, D) ->
    lists:map(fun(C) -> case C of $I -> $M end end, roman(units, D)).
