%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(bank_account).
-behavior(gen_statem).

-export([callback_mode/0, init/1, terminate/3, code_change/4]).
-export([open/3, closed/3]).
-export([balance/1, charge/2, close/1, create/0, deposit/2, withdraw/2, test_version/0]).

balance(AccountPid) ->
	gen_statem:call(AccountPid, balance).

charge(AccountPid, Amount) ->
	gen_statem:call(AccountPid, {charge, Amount}).

close(AccountPid) ->
	gen_statem:call(AccountPid, close).

create() ->
	{ok, AccountPid} = gen_statem:start_link(?MODULE, [], []),
	AccountPid.

deposit(AccountPid, Amount) ->
	gen_statem:call(AccountPid, {deposit, Amount}).

withdraw(AccountPid, Amount) ->
	gen_statem:call(AccountPid, {withdraw, Amount}).

callback_mode() -> state_functions.

init([]) -> {ok, open, 0}.

open({call, From}, {deposit, Amount}, Balance) ->
	{NewBalance, Reply} =
	case Amount >= 0 of
		true -> {Balance + Amount, Balance + Amount};
		false -> {Balance, Balance}
	end,
	{next_state, open, NewBalance, [{reply, From, Reply}]};

open({call, From}, {charge, Amount}, Balance) ->
	{NewBalance, Reply} =
	case {Amount >= 0, Amount =< Balance} of
		{true, true} -> {Balance - Amount, Amount};
		_ -> {Balance, 0}
	end,
	{next_state, open, NewBalance, [{reply, From, Reply}]};

open({call, From}, {withdraw, Amount}, Balance) ->
	{NewBalance, Reply} =
	case {Amount >= 0, Amount =< Balance} of
		{true, true} -> {Balance - Amount, Amount};
		{false, _} -> {Balance, 0};
		{_, false} -> {0, Balance}
	end,
	{next_state, open, NewBalance, [{reply, From, Reply}]};

open({call, From}, balance, Balance) ->
	{next_state, open, Balance, [{reply, From, Balance}]};

open({call, From}, close, Balance) ->
	{next_state, closed, 0, [{reply, From, Balance}]};

open(_, _, Balance) ->
	{next_state, open, Balance}.

closed({call, From}, _, Balance) ->
	{next_state, closed, Balance, [{reply, From, {error, account_closed}}]};

closed(_, _, Balance) ->
	{next_state, closed, Balance}.

terminate(_, _, _) -> ok.

code_change(_, State, StateData, _) -> {ok, State, StateData}.

test_version() -> 1.
