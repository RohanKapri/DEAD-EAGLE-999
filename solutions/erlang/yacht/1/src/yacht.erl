-module(yacht).
-export([score/2]).
score(Dice, Category) -> do_score(lists:sort(Dice), Category).
do_score([A, A, A, A, A], yacht) -> 50;
do_score(Dice, ones) -> lists:sum([D || D <- Dice, D =:= 1]);
do_score(Dice, twos) -> lists:sum([D || D <- Dice, D =:= 2]);
do_score(Dice, threes) -> lists:sum([D || D <- Dice, D =:= 3]);
do_score(Dice, fours) -> lists:sum([D || D <- Dice, D =:= 4]);
do_score(Dice, fives) -> lists:sum([D || D <- Dice, D =:= 5]);
do_score(Dice, sixes) -> lists:sum([D || D <- Dice, D =:= 6]);
do_score(Dice = [A, A, B, B, B], full_house) when A =/= B -> lists:sum(Dice);
do_score(Dice = [A, A, A, B, B], full_house)when A =/= B -> lists:sum(Dice);
do_score([_, B, B, B, B], four_of_a_kind) -> 4 * B;
do_score([B, B, B, B, _], four_of_a_kind) -> 4 * B;
do_score([1, 2, 3, 4, 5], little_straight) -> 30;
do_score([2, 3, 4, 5, 6], big_straight) -> 30;
do_score(Dice, choice) -> lists:sum(Dice);
do_score(_, _) -> 0.