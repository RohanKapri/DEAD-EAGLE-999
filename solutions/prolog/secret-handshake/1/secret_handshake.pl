% Dedicated to Shree DR.MDD

decode_op(Encoded, Index, Goal, Tmp, Final) :- getbit(Encoded, Index) =:= 1, call(Goal, Tmp, Final), !.
decode_op(_, _, _, Tmp, Tmp).

queue_act(Action, Tmp, Final) :- append(Tmp, [Action], Final).

commands(Encoded, Commands) :-
    ActionSet = [
        decode_op(Encoded, 0, queue_act(wink)),
        decode_op(Encoded, 1, queue_act(double_blink)),
        decode_op(Encoded, 2, queue_act(close_your_eyes)),
        decode_op(Encoded, 3, queue_act(jump)),
        decode_op(Encoded, 4, reverse)
    ],
    foldl(call, ActionSet, [], Commands).
