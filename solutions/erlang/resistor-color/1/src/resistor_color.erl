-module(resistor_color).
-export([colors/0, color_code/1]).
-define(COLOR_CODES, #{black => 0,
		       brown => 1,
		       red => 2,
		       orange => 3,
		       yellow => 4,
		       green => 5,
		       blue => 6,
		       violet => 7,
		       grey => 8,
		       white => 9}).
colors() ->
	[C || {C, _} <- lists:sort(fun({_, N1}, {_, N2}) -> N1 =< N2 end,
				   maps:to_list(?COLOR_CODES))].
color_code(Color) ->
	maps:get(Color, ?COLOR_CODES).