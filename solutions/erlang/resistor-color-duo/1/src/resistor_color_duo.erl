-module(resistor_color_duo).
-export([value/1]).
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
value([C1, C2|_]) ->
	 10*maps:get(C1, ?COLOR_CODES)
	+   maps:get(C2, ?COLOR_CODES).