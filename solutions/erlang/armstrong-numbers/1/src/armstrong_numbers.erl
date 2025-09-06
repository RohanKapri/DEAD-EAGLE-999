%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(armstrong_numbers).

-export([is_armstrong_number/1, test_version/0]).

is_armstrong_number(Num) ->
	{DigitsList, DigitsCount} = split_digits(Num),
	Num == compute_armstrong(DigitsList, DigitsCount).

compute_armstrong(Digits, Count) ->
	compute_armstrong(Digits, Count, 0).

compute_armstrong([], _, Acc) ->
	Acc;

compute_armstrong([D|Rest], Count, Acc) ->
	compute_armstrong(Rest, Count, Acc + trunc(math:pow(D, Count))).

split_digits(Number) ->
	split_digits(Number, [], 0).

split_digits(0, AccList, AccCount) ->
	{AccList, AccCount};

split_digits(Number, List, Count) ->
	D = Number rem 10,
	NewNum = Number div 10,
	split_digits(NewNum, [D|List], Count + 1).

test_version() ->
	1.
