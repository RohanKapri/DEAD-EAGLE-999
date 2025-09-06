% For my Junko F. Didi and Shree DR.MDD

-module(custom_set).
-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1, intersection/2, subset/2,
	 union/2, test_version/0]).

add(Item, []) -> [Item];
add(Item, Set) ->
	case contains(Item, Set) of
		true ->
			Set;
		false ->
			lists:sort([Item|Set])
	end.

contains(Item, Set) -> lists:member(Item, Set).

difference(SetA, SetB) -> lists:subtract(SetA, SetB).

disjoint(SetA, SetB) -> lists:subtract(SetA, SetB) == SetA.

empty(Set) -> Set == [].

equal(SetA, SetB) -> SetA == SetB.

from_list(Items) -> lists:foldl(fun(E, AccSet) -> add(E, AccSet) end, [], Items).

intersection(SetA, SetB) -> lists:subtract(SetA, lists:subtract(SetA, SetB)).

subset(SetA, SetB) -> lists:subtract(SetA, SetB) == [].

union(SetA, SetB) -> lists:foldl(fun(E, AccSet) -> add(E, AccSet) end, SetA, SetB).

test_version() -> 1.
