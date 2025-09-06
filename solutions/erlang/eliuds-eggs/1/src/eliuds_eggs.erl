-module(eliuds_eggs).

-export([egg_count/1]).


egg_count(0) ->
	0;
egg_count(N) ->
	N1 = N bsr 1,
	case N band 1 of
		1 ->
			1+egg_count(N1);
		0 ->
			egg_count(N1)
	end.