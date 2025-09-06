%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(perfect_numbers).

-export([classify/1]).

aliquot(SumNum) -> 
  case SumNum of
    X when X < 1 -> erlang:error(badarg);
    1 -> 0;
    _ -> 
      RootMax = trunc(math:sqrt(SumNum)),
      aliquot(SumNum, RootMax, 2, 1)
  end.

aliquot(_Num, MaxRoot, Idx, Total) when Idx > MaxRoot -> Total;
aliquot(Num, MaxRoot, Idx, Total) ->
  case Num rem Idx of
    0 -> 
      Complement = Num div Idx,
      NewTotal = Total + Idx + (case Complement of X when X > Idx -> X; _ -> 0 end),
      aliquot(Num, MaxRoot, Idx + 1, NewTotal);
    _ -> aliquot(Num, MaxRoot, Idx + 1, Total)
  end.

classify(Value) -> 
  case aliquot(Value) - Value of
    0 -> perfect;
    Pos when Pos > 0 -> abundant;
    _ -> deficient
  end.
