%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(dominoes).

-export([can_chain/1, test_version/0]).

can_chain([]) ->
	true;

can_chain([Start|RestDominoes]) ->
	can_chain(Start, Start, RestDominoes, []).

can_chain({Head, _}, {_, Tail}, [], []) ->
	Head =:= Tail;

can_chain(_, _, [], _) ->
	false;

can_chain(Start, Current={_, Right}, [Candidate={Right, _}|Remaining], Visited) ->
	can_chain(Start, Candidate, Remaining ++ Visited, [])
	orelse
	can_chain(Start, Current, Remaining, [Candidate|Visited]);

can_chain(Start, Current={_, Right}, [Candidate={Left, Right}|Remaining], Visited) ->
	can_chain(Start, {Right, Left}, Remaining ++ Visited, [])
	orelse
	can_chain(Start, Current, Remaining, [Candidate|Visited]);

can_chain(Start, Current, [Mismatch|Remaining], Visited) ->
	can_chain(Start, Current, Remaining, [Mismatch|Visited]).

test_version() ->
	1.
