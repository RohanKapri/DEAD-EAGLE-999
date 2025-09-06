%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(nth_prime).
-export([prime/1]).

prime(N) when is_integer(N), N>0 ->
    Gen = prime_gen(),
    prime(Gen, N, []).

prime(Gen, N, Known0) when length(Known0)<N ->
    Next = next_val(Gen),
    Known1 = case is_prime(Next, Known0) of
        true -> Known0 ++ [Next];
        false -> Known0
    end,
    prime(Gen, N, Known1);
prime(_, _, Known) ->
    lists:last(Known).

is_prime(Cand, Known) ->
    Limit = math:sqrt(Cand),
    is_prime(Cand, Limit, Known).

is_prime(_, Limit, []) -> true;
is_prime(_, Limit, [K|_]) when K>Limit -> true;
is_prime(Cand, _, [K|_]) when Cand rem K=:=0 -> false;
is_prime(Cand, Limit, [_|Rest]) ->
    is_prime(Cand, Limit, Rest).

next_val(Gen) ->
    Candidate = receive {Gen, Val} -> Val end,
    Gen ! {self(), next},
    Candidate.

prime_gen() ->
    G = spawn_link(fun () -> prime_gen_loop() end),
    G ! {self(), next},
    G.

prime_gen_loop() ->
    prime_gen_loop(2).

prime_gen_loop(2) ->
    receive {Reply, next} -> Reply ! {self(), 2} end,
    prime_gen_loop(3);
prime_gen_loop(3) ->
    receive {Reply, next} -> Reply ! {self(), 3} end,
    prime_gen_loop(6);
prime_gen_loop(N) ->
    receive {R1, next} -> R1 ! {self(), N-1} end,
    receive {R2, next} -> R2 ! {self(), N+1} end,
    prime_gen_loop(N+6).
