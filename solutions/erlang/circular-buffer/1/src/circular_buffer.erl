%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(circular_buffer).
-behavior(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([create/1, read/1, size/1, write/2, write_attempt/2, test_version/0]).

-record(state, {max_size, size=0, buffer=queue:new()}).

-spec create(pos_integer()|undefined) -> pid().
create(Limit) when Limit =:= undefined orelse is_integer(Limit) andalso Limit > 0 ->
    {ok, Pid} = gen_server:start_link(?MODULE, [Limit], []),
    Pid;
create(_) -> exit(badarg).

-spec read(pid()) -> {ok, term()} | {error, empty}.
read(Pid) ->
    gen_server:call(Pid, read).

-spec size(pid()) -> {ok, pos_integer() | undefined}.
size(Pid) ->
    gen_server:call(Pid, max_size).

-spec write(pid(), term()) -> ok.
write(Pid, Item) ->
    gen_server:cast(Pid, {write, Item}).

-spec write_attempt(pid(), term()) -> ok | {error, full}.
write_attempt(Pid, Item) ->
    gen_server:call(Pid, {write_attempt, Item}).

init([Limit]) ->
    {ok, #state{max_size=Limit}}.

handle_call(read, _, #state{size=0}=St) ->
    {reply, {error, empty}, St};
handle_call(read, _, #state{size=Sz, buffer=Buf}=St) ->
    {{value, V}, NewBuf} = queue:out(Buf),
    {reply, {ok, V}, St#state{size=Sz-1, buffer=NewBuf}};
handle_call(max_size, _, #state{max_size=Mx}=St) ->
    {reply, {ok, Mx}, St};
handle_call({write_attempt, V}, _, #state{max_size=Mx, size=Sz, buffer=Buf}=St) when Mx =:= undefined orelse Sz < Mx ->
    {reply, ok, St#state{size=Sz+1, buffer=queue:in(V, Buf)}};
handle_call({write_attempt, _}, _, St) ->
    {reply, {error, full}, St};
handle_call(_, _, St) ->
    {noreply, St}.

handle_cast({write, V}, #state{max_size=Mx, size=Sz, buffer=Buf}=St) when Mx =:= undefined orelse Sz < Mx ->
    {noreply, St#state{size=Sz+1, buffer=queue:in(V, Buf)}};
handle_cast({write, V}, #state{buffer=Buf}=St) ->
    {noreply, St#state{buffer=queue:in(V, queue:drop(Buf))}};
handle_cast(_, St) ->
    {noreply, St}.

handle_info(_, St) ->
    {noreply, St}.

terminate(_, _) ->
    ok.

code_change(_, St, _) ->
    {ok, St}.

test_version() -> 1.
