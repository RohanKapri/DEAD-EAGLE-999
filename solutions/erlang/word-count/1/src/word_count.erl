%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(word_count).
-export([count_words/1]).

count_words(Sentence) ->
    Tokens = tokenize_words(Sentence),
    lists:foldl(fun inc_map/2, #{}, Tokens).

inc_map(Key, Map) ->
    Map#{Key => maps:get(Key, Map, 0) + 1}.

tokenize_words(Sentence) ->
    tokenize_words(lists:reverse(Sentence), [], []).

tokenize_words([C|Rest], Word, Acc) when
    (C >= $a andalso C =< $z) orelse
    (C >= $0 andalso C =< $9) ->
        tokenize_words(Rest, [C|Word], Acc);
tokenize_words([C|Rest], Word, Acc) when C >= $A, C =< $Z ->
        tokenize_words(Rest, [C-$A+$a|Word], Acc);
tokenize_words([$'|Rest], [], Acc) ->
        tokenize_words(Rest, [], Acc);
tokenize_words([$'|Rest], Word, Acc) ->
        tokenize_words(Rest, [$'|Word], Acc);
tokenize_words([_|Rest], [], Acc) ->
        tokenize_words(Rest, [], Acc);
tokenize_words([_|Rest], [$'|Word], Acc) ->
        tokenize_words(Rest, [], [Word|Acc]);
tokenize_words([_|Rest], Word, Acc) ->
        tokenize_words(Rest, [], [Word|Acc]);
tokenize_words([], [], Acc) ->
        Acc;
tokenize_words([], [$'|Word], Acc) ->
        [Word|Acc];
tokenize_words([], Word, Acc) ->
        [Word|Acc].
