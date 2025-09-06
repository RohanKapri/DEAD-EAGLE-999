%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(zipper).
-export([new_tree/3, from_tree/1, to_tree/1, up/1, left/1, right/1, value/1, set_value/2, set_left/2, set_right/2, test_version/0]).

-record(tree, {value, left, right}).
-record(zipper, {history=[], current}).
-record(history_item, {was, value, tree}).

new_tree(Val, L, R) -> #tree{value=Val, left=L, right=R}.

to_tree(Z) -> (top(Z))#zipper.current.

from_tree(T) -> #zipper{current=T}.

value(#zipper{current=#tree{value=V}}) -> V.

set_value(Z=#zipper{current=T}, V) -> Z#zipper{current=T#tree{value=V}}.

set_left(Z=#zipper{current=T}, L) -> Z#zipper{current=T#tree{left=L}}.

set_right(Z=#zipper{current=T}, R) -> Z#zipper{current=T#tree{right=R}}.

left(Z=#zipper{history=H, current=#tree{value=V, left=L, right=R}}) ->
    case L of
        #tree{} -> Z#zipper{history=[#history_item{was=right, value=V, tree=R}|H], current=L};
        _ -> L
    end.

right(Z=#zipper{history=H, current=#tree{value=V, left=L, right=R}}) ->
    case R of
        #tree{} -> Z#zipper{history=[#history_item{was=left, value=V, tree=L}|H], current=R};
        _ -> R
    end.

up(#zipper{history=[]}) -> nil;
up(Z=#zipper{history=[#history_item{was=right, value=V, tree=R}|H], current=L}) ->
    Z#zipper{history=H, current=#tree{value=V, left=L, right=R}};
up(Z=#zipper{history=[#history_item{was=left, value=V, tree=L}|H], current=R}) ->
    Z#zipper{history=H, current=#tree{value=V, left=L, right=R}}.

top(Z=#zipper{history=[]}) -> Z;
top(Z) -> top(up(Z)).

test_version() -> 1.
