-module(list_ops).
-compile({no_auto_import, [length/1]}).
-export([append/2, concat/1, filter/2, length/1, map/2, foldl/3, foldr/3,
	 reverse/1]).
append([], L2) -> L2;
append([E|L1], L2) -> [E|append(L1, L2)].
concat([]) -> [];
concat([E|L]) -> append(E, concat(L)).
filter(_, []) -> [];
filter(F, [E|L]) -> case F(E) of true -> [E|filter(F, L)]; false -> filter(F, L) end.
length([]) -> 0;
length([_|L]) -> 1+length(L).
map(_, []) -> [];
map(F, [E|L]) -> [F(E)|map(F, L)].
foldl(_, Acc, []) -> Acc;
foldl(F, Acc, [E|L]) -> foldl(F, F(E, Acc), L).
foldr(F, S, L) -> foldl(F, S, reverse(L)).
reverse(L) -> reverse(L, []).
reverse([], Acc) -> Acc;
reverse([E|L], Acc) -> reverse(L, [E|Acc]).