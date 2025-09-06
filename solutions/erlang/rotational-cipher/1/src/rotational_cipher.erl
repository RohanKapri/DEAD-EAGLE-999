-module(rotational_cipher).

-export([encrypt/2, decrypt/2, test_version/0]).

encrypt(String, 0) -> String;
encrypt(String, N) when N<0 -> encrypt(String, N+26);
encrypt(String, N) when N>=26 -> encrypt(String, N-26);
encrypt(String, N) -> encrypt(String, N, []).

encrypt([], _, Acc) -> lists:reverse(Acc);
encrypt([C|More], N, Acc) when C>=$a andalso C=<$z -> encrypt(More, N, [$a+((C-$a+N) rem 26)|Acc]);
encrypt([C|More], N, Acc) when C>=$A andalso C=<$Z -> encrypt(More, N, [$A+((C-$A+N) rem 26)|Acc]);
encrypt([C|More], N, Acc) -> encrypt(More, N, [C|Acc]).

decrypt(String, N) -> encrypt(String, -N).

test_version() -> 1.