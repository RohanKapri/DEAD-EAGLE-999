-module(reverse_string).

-export([reverse/1]).

reverse(String) ->
	lists:reverse(String).