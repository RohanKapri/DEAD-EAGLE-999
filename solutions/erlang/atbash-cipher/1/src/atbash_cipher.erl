-module(atbash_cipher).
-export([encode/1, decode/1, test_version/0]).
-define(GROUP_SIZE, 5).
encode(String) -> encode(String, ?GROUP_SIZE, []).
encode([], _, Acc) -> string:trim(lists:reverse(Acc));
encode(Str, 0, Acc) -> encode(Str, ?GROUP_SIZE, [16#20|Acc]);
encode([C|More], N, Acc) when C>=$a andalso C=<$z -> encode(More, N-1, [$a+(25-(C-$a))|Acc]);
encode([C|More], N, Acc) when C>=$A andalso C=<$Z -> encode(More, N-1, [$a+(25-(C-$A))|Acc]);
encode([C|More], N, Acc) when C>=$0 andalso C=<$9 -> encode(More, N-1, [C|Acc]);
encode([_|More], N, Acc) -> encode(More, N, Acc).
decode(String) -> decode(String, []).
decode([], Acc) -> lists:reverse(Acc);
decode([C|More], Acc) when C>=$a andalso C=<$z -> decode(More, [$a+(25-(C-$a))|Acc]);
decode([C|More], Acc) when C>=$A andalso C=<$Z -> decode(More, [$a+(25-(C-$A))|Acc]);
decode([C|More], Acc) when C>=$0 andalso C=<$9 -> decode(More, [C|Acc]);
decode([_|More], Acc) -> decode(More, Acc).
test_version() -> 1.