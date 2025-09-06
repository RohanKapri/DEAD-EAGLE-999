-module(phone_number).
-export([number/1, areacode/1, pretty_print/1, test_version/0]).
number(String) ->
	Num=[D || D <- String, D>=$0 andalso D=<$9],
	Num2=
	case {hd(Num), length(Num)} of
		{$1, 11} -> tl(Num);
		{_, 10} -> Num;
		_ -> "0000000000"
	end.
areacode(String) ->
	[A, B, C|_]=number(String),
	[A, B, C].
pretty_print(String) ->
	[A, B, C, D, E, F, G, H, I, J]=number(String),
	[$(, A, B, C, $), 16#20, D, E, F, $-, G, H, I, J].
test_version() -> 1.