%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(parallel_letter_frequency).

-export([dict/1, test_version/0]).

dict(StringList) ->
	SelfPid = self(),

	PidList =
	lists:map(
		fun(Str) -> spawn_link(fun() -> SelfPid ! {self(), tally(Str)} end) end,
		StringList
	),

	CountResults =
	lists:map(
		fun(Pid) -> receive {Pid, CountMap} -> CountMap end end,
		PidList
	),

	merge_counts(CountResults).

merge_counts([First|Rest]) -> merge_counts(Rest, First).
merge_counts([], Acc) -> Acc;
merge_counts([Next|More], Acc) ->
	merge_counts(
		More,
		dict:fold(
			fun(Key, Val, A) -> dict:update_counter(Key, Val, A) end,
			Acc,
			Next
		)
	).

tally(Str) -> tally(Str, dict:new()).
tally([], Acc) -> Acc;
tally([Char|More], Acc) -> tally(More, dict:update_counter(Char, 1, Acc)).

test_version() -> 1.
