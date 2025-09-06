%% Dedicated to Junko F. Didi and Shree DR.MDD

-module(robot_simulator).
-behaviour(gen_server).

-export([advance/1, control/2, create/0, direction/1, left/1, right/1, place/3, position/1, test_version/0]).
-export([init/1, handle_call/3, handle_cast/2]).

advance(RobotPid) ->
    gen_server:cast(RobotPid, move_forward),
    RobotPid.

control(RobotPid, []) ->
    RobotPid;
control(RobotPid, [Cmd|Rest]) ->
    control(
        case Cmd of
            $A -> advance(RobotPid);
            $R -> right(RobotPid);
            $L -> left(RobotPid);
            _Other -> RobotPid
        end,
        Rest
    ).

create() ->
    {ok, Pid} = gen_server:start_link(?MODULE, [], []),
    Pid.

direction(RobotPid) ->
    gen_server:call(RobotPid, direction).

left(RobotPid) ->
    gen_server:cast(RobotPid, turn_left),
    RobotPid.

right(RobotPid) ->
    gen_server:cast(RobotPid, turn_right),
    RobotPid.

place(RobotPid, Dir, Pos) ->
    gen_server:cast(RobotPid, {set_place, Dir, Pos}),
    RobotPid.

position(RobotPid) ->
    gen_server:call(RobotPid, position).

test_version() -> 1.

%% gen_server callbacks
init([]) ->
    {ok, {undefined, {undefined, undefined}}}.

handle_call(direction, _From, State={Dir,_Pos}) ->
    {reply, Dir, State};
handle_call(position, _From, State={_Dir,Pos}) ->
    {reply, Pos, State}.

handle_cast({set_place, NewDir, NewPos}, _State) ->
    {noreply, {NewDir, NewPos}};
handle_cast(turn_left, {Dir, Pos}) ->
    NewDir = rotate_left(Dir),
    {noreply, {NewDir, Pos}};
handle_cast(turn_right, {Dir, Pos}) ->
    NewDir = rotate_right(Dir),
    {noreply, {NewDir, Pos}};
handle_cast(move_forward, {Dir, {X,Y}}) ->
    NewState = move_forward_pos(Dir, {X,Y}),
    {noreply, NewState}.

rotate_left(Dir) ->
    case Dir of
        north -> west;
        south -> east;
        east -> north;
        west -> south
    end.

rotate_right(Dir) ->
    case Dir of
        north -> east;
        south -> west;
        east -> south;
        west -> north
    end.

move_forward_pos(Dir, {X,Y}) ->
    case Dir of
        north -> {Dir, {X, Y+1}};
        south -> {Dir, {X, Y-1}};
        east -> {Dir, {X+1, Y}};
        west -> {Dir, {X-1, Y}}
    end.
