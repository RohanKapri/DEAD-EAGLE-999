-module(matching_brackets).
-export([is_paired/1]).
is_paired(Input) ->
    is_paired(Input, []).
is_paired([], []) ->
    true;
is_paired([], _) ->
    false;
is_paired([Head|Input], Stack) when Head =:= $(; Head =:= ${; Head =:= $[ ->
    is_paired(Input, [Head|Stack]);
is_paired([$)|Input], [$(|Stack]) ->
    is_paired(Input, Stack);
is_paired([$}|Input], [${|Stack]) ->
    is_paired(Input, Stack);
is_paired([$]|Input], [$[|Stack]) ->
    is_paired(Input, Stack);
is_paired([Head|_], _) when Head =:= $); Head =:= $}; Head =:= $] ->
    false;
is_paired([_|Input], Stack) ->
    is_paired(Input, Stack).