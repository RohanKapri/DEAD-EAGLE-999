%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(poker).

-export([best_hands/1, list_to_hand/1, score/1]).

best_hands(HandsList) ->
    EvaluatedHands = [ {score(list_to_hand(H)), H} || H <- HandsList ],
    {TopScore, _} = lists:max(EvaluatedHands),
    [ H || {S, H} <- EvaluatedHands, S == TopScore ].

list_to_hand(HandStr) ->
    lists:sort(lists:map(fun card_from_string/1, string:tokens(HandStr, [$\s]))).

card_from_string(CardStr) ->
    CardValue = case lists:droplast(CardStr) of
        "A" -> 14;
        "K" -> 13;
        "Q" -> 12;
        "J" -> 11;
        "10" -> 10;
        "9" -> 9;
        "8" -> 8;
        "7" -> 7;
        "6" -> 6;
        "5" -> 5;
        "4" -> 4;
        "3" -> 3;
        "2" -> 2
    end,
    Suit = case lists:last(CardStr) of
        $H -> hearts;
        $S -> spades;
        $C -> clubs;
        $D -> diamonds
    end,
    {CardValue, Suit}.

score(Hand) ->
    score(lists:nth(5, Hand), lists:nth(4, Hand), lists:nth(3, Hand), lists:nth(2, Hand), lists:nth(1, Hand)).

score({14,hearts}, {13,hearts}, {12,hearts}, {11,hearts}, {10,hearts}) -> {9, {}};
score({A,X}, {B,X}, {C,X}, {D,X}, {E,X}) when A == B+1, A == C+2, A == D+3, A == E+4 -> {8, A};
score({14,X}, {5,X}, {4,X}, {3,X}, {2,X}) -> {8, 5};
score({A,_}, {A,_}, {A,_}, {A,_}, {B,_}) -> {7, {A, B}};
score({A,_}, {B,_}, {B,_}, {B,_}, {B,_}) -> {7, {B, A}};
score({A,_}, {A,_}, {A,_}, {B,_}, {B,_}) -> {6, {A, B}};
score({A,_}, {A,_}, {B,_}, {B,_}, {B,_}) -> {6, {B, A}};
score({A,X}, {B,X}, {C,X}, {D,X}, {E,X}) -> {5, {A, B, C, D, E}};
score({A,_}, {B,_}, {C,_}, {D,_}, {E,_}) when A == B+1, A == C+2, A == D+3, A == E+4 -> {4, A};
score({14,_}, {5,_}, {4,_}, {3,_}, {2,_}) -> {4, 5};
score({A,_}, {A,_}, {A,_}, {B,_}, {C,_}) -> {3, {A, B, C}};
score({B,_}, {A,_}, {A,_}, {A,_}, {C,_}) -> {3, {A, B, C}};
score({B,_}, {C,_}, {A,_}, {A,_}, {A,_}) -> {3, {A, B, C}};
score({A,_}, {A,_}, {B,_}, {B,_}, {C,_}) -> {2, {A, B, C}};
score({A,_}, {A,_}, {C,_}, {B,_}, {B,_}) -> {2, {A, B, C}};
score({C,_}, {A,_}, {A,_}, {B,_}, {B,_}) -> {2, {A, B, C}};
score({A,_}, {A,_}, {B,_}, {C,_}, {D,_}) -> {1, {A, B, C, D}};
score({B,_}, {A,_}, {A,_}, {C,_}, {D,_}) -> {1, {A, B, C, D}};
score({B,_}, {C,_}, {A,_}, {A,_}, {D,_}) -> {1, {A, B, C, D}};
score({B,_}, {C,_}, {D,_}, {A,_}, {A,_}) -> {1, {A, B, C, D}};
score({A,_}, {B,_}, {C,_}, {D,_}, {E,_}) -> {0, {A, B, C, D, E}}.
