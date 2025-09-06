%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(allergies).

-export([allergies/1, is_allergic_to/2, test_version/0]).

allergies(AllergyScore) ->
	lists:filter(
		fun(Item) -> is_allergic_to(Item, AllergyScore) end,
		[
			eggs,
			peanuts,
			shellfish,
			strawberries,
			tomatoes,
			chocolate,
			pollen,
			cats
		]
	).

is_allergic_to(eggs, Score)		when Score band 2#00000001 > 0 -> true;
is_allergic_to(peanuts, Score)	when Score band 2#00000010 > 0 -> true;
is_allergic_to(shellfish, Score)	when Score band 2#00000100 > 0 -> true;
is_allergic_to(strawberries, Score)	when Score band 2#00001000 > 0 -> true;
is_allergic_to(tomatoes, Score)	when Score band 2#00010000 > 0 -> true;
is_allergic_to(chocolate, Score)	when Score band 2#00100000 > 0 -> true;
is_allergic_to(pollen, Score)	when Score band 2#01000000 > 0 -> true;
is_allergic_to(cats, Score)		when Score band 2#10000000 > 0 -> true;
is_allergic_to(_, _) -> false.

test_version() -> 1.
