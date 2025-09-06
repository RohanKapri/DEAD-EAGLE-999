-module(minesweeper).

-export([annotate/1, test_version/0]).

annotate([]) -> [];
annotate(Minefield) ->
  Map = gen_map(Minefield),
  Width = length(hd(Minefield)),
  Height = length(Minefield),
  [
    [
      value(Map, X, Y)
      || X <- lists:seq(1, Width)
    ]
    || Y <- lists:seq(1, Height)
  ].

gen_map([Cols|Rows]) ->
  gen_map(#{}, Rows, Cols, 1, 1).

gen_map(Map, [], [], _X, _Y) ->
  Map;
gen_map(Map, [[Col|Cols]|Rows], [], _X, Y) ->
  gen_map(Map#{{1,Y+1} => Col}, Rows, Cols, 2, Y+1);
gen_map(Map, Rows, [Col|Cols], X, Y) ->
  gen_map(Map#{{X,Y} => Col}, Rows, Cols, X+1, Y).

is_mine(Map, X, Y) ->
  case maps:get({X,Y}, Map, $\s) of
    $\s -> 0;
    $* -> 1
  end.

value(Map, X, Y) ->
  case is_mine(Map, X, Y) of
    1 -> $*;
    0 ->
      Value = surrounding_mines(Map, X, Y),
      case Value of
        0 -> $\s;
        _ -> $0+Value
      end
  end.

surrounding_mines(Map, X, Y) ->
  is_mine(Map, X-1, Y-1) +
  is_mine(Map, X, Y-1) +
  is_mine(Map, X+1, Y-1) +
  is_mine(Map, X-1, Y) +
  is_mine(Map, X+1, Y) +
  is_mine(Map, X-1, Y+1) +
  is_mine(Map, X, Y+1) +
  is_mine(Map, X+1, Y+1).

test_version() -> 1.