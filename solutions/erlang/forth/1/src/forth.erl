%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(forth).

-export([evaluate/1]).

evaluate(Instructions) ->
    InstructionString = string:join(Instructions, " "),
    WordList = string:split(InstructionString, " ", all),
    Tokens = lists:map(
        fun(Word) ->
            try list_to_integer(Word) of
                Num -> Num
            catch
                _:_ -> list_to_atom(string:casefold(Word))
            end
        end,
        WordList),
    {normal, Chunks} = lists:foldl(
        fun
            (':', {normal, Acc}) -> {definition_start, Acc};
            (';', {def, Acc}) -> {normal, Acc};
            (Name, {definition_start, Acc}) -> {def, [{Name, []} | Acc]};
            (Token, {def, [{Name, SubTokens} | Acc]}) ->
                {def, [{Name, SubTokens ++ [Token]} | Acc]};
            (Token, {normal, Acc}) -> {normal, [Token | Acc]}
        end,
        {normal, []},
        Tokens
    ),
    FinalStack = evaluate(lists:reverse(Chunks), [], base_mappings()),
    lists:reverse(FinalStack).

evaluate([], [], _) -> [];
evaluate([], [Num|_] = Stack, _) when is_number(Num) -> Stack;

evaluate([{Name, Ops} | Rest], Stack, Mappings) when not is_number(Name) ->
    Action = fun(St) ->
        lists:foldl(
            fun
                (X, S) when is_number(X) -> [X | S];
                (Op, S) ->
                    Func = maps:get(Op, Mappings),
                    Func(S)
            end,
            St,
            Ops
        )
    end,
    UpdatedMappings = maps:put(Name, Action, Mappings),
    evaluate(Rest, Stack, UpdatedMappings);

evaluate(Rest, [Op | Stack], Mappings) when not is_number(Op) ->
    Func = maps:get(Op, Mappings),
    NewStack = Func(Stack),
    evaluate(Rest, NewStack, Mappings);

evaluate([Word | Rest], Stack, Mappings) ->
    evaluate(Rest, [Word | Stack], Mappings).

base_mappings() ->
    #{
        '+' => fun([A, B | Rest]) -> [A + B | Rest] end,
        '-' => fun([A, B | Rest]) -> [B - A | Rest] end,
        '*' => fun([A, B | Rest]) -> [A * B | Rest] end,
        '/' => fun([A, B | Rest]) -> [B div A | Rest] end,
        'dup' => fun([A | Rest]) -> [A, A | Rest] end,
        'drop' => fun([_ | Rest]) -> Rest end,
        'swap' => fun([A, B | Rest]) -> [B, A | Rest] end,
        'over' => fun([A, B | Rest]) -> [B, A, B | Rest] end
    }.
