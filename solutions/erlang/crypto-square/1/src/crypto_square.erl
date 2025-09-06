%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(crypto_square).
-export([ciphertext/1, test_version/0]).

ciphertext(Plain) ->
    Norm = normalize_text(Plain),
    Dim = calc_grid(Norm),
    encode_text(Norm, Dim).

normalize_text(S) ->
    normalize_text(S, []).

normalize_text([], Acc) ->
    lists:reverse(Acc);
normalize_text([C|Rest], Acc) when C>=$a, C=<$z; C>=$0, C=<$9 ->
    normalize_text(Rest, [C|Acc]);
normalize_text([C|Rest], Acc) when C>=$A, C=<$Z ->
    normalize_text(Rest, [C-$A+$a|Acc]);
normalize_text([_|Rest], Acc) ->
    normalize_text(Rest, Acc).

calc_grid(S) ->
    Len = length(S),
    Sqrt = math:sqrt(Len),
    R = trunc(Sqrt),
    C = ceil(Sqrt),
    {C, R}.

ceil(N) ->
    T = trunc(N),
    if T-N < 0 -> T+1; true -> T end.

encode_text([], _) -> [];
encode_text(S, {C,_}) ->
    Chunks = make_chunks(S, C),
    Trans = transpose_matrix(Chunks),
    join_flat(Trans).

join_flat(L) ->
    join_flat(L, []).

join_flat([], Acc) -> Acc;
join_flat([E|Rest], []) -> join_flat(Rest, E);
join_flat([E|Rest], Acc) -> join_flat(Rest, Acc++[16#20|E]).

make_chunks(S, L) ->
    make_chunks(S, L, []).

make_chunks([], _, Acc) ->
    lists:reverse(Acc);
make_chunks(S, L, Acc) when length(S) < L ->
    Pad = [16#20 || _ <- lists:seq(length(S)+1,L)],
    lists:reverse([S++Pad|Acc]);
make_chunks(S, L, Acc) ->
    {Chunk, Rest} = lists:split(L, S),
    make_chunks(Rest, L, [Chunk|Acc]).

transpose_matrix(Mat) ->
    transpose_matrix([], Mat, [[]]).

transpose_matrix([], [], [A|Acc]) ->
    lists:reverse([lists:reverse(A)|Acc]);
transpose_matrix(Lft, [], [A|Acc]) ->
    transpose_matrix([], lists:reverse(Lft), [[], lists:reverse(A)|Acc]);
transpose_matrix(Lft, [[C]|MR], [A|Acc]) ->
    transpose_matrix(Lft, MR, [[C|A]|Acc]);
transpose_matrix(Lft, [[C|MR]|MRR], [A|Acc]) ->
    transpose_matrix([MR|Lft], MRR, [[C|A]|Acc]).

test_version() -> 1.
