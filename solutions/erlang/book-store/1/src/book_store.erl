-module(book_store).
-export([total/1]).
total(Basket) ->
  Map = #{1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0},
  Fun = fun(X, A) -> maps:update_with(X, fun(V) -> V + 1 end, A) end,
  Agg = lists:foldl(Fun, Map, Basket),
  Counts = lists:sort(maps:values(Agg)),
  calculate(Counts, 0).
calculate([0, 0, 0, 0, A], Acc) -> Acc + A * 800;
calculate([0, 0, 0, A, B], Acc) -> calculate([0, 0, 0, A-1, B-1], Acc + 2 * 760);
calculate([0, 0, A, B, C], Acc) -> calculate([0, 0, A-1, B-1, C-1], Acc + 3 * 720);
calculate([0, A, B, C, D], Acc) -> calculate([0, A-1, B-1, C-1, D-1], Acc + 4 * 640);
calculate([A, B, C, D, E], Acc) ->
  lists:min([
    calculate([A-1, B-1, C-1, D-1, E-1], Acc + 5 * 600),
    calculate(lists:sort([A, B-1, C-1, D-1, E-1]), Acc + 4 * 640)
  ]).