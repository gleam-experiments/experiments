-module(gleam_otp_process_native).

% Public API functions
-export([start/2, sync/3]).

% Private system exports
-export([init/2, loop/3, system_continue/3, system_terminate/4, write_debug/3,
         system_get_state/1, system_replace_state/2]).

%% Public API

start(State, Routine) ->
  proc_lib:start_link(?MODULE, init, [Routine, State, self()]).

sync(Pid, Timeout, Msg) ->
    Ref = make_ref(),
    Pid ! {sync, Ref, self(), Msg},
    receive
        {Ref, Reply} -> Reply
    after
        Timeout -> error(gleam_otp_agent_sync_timeout)
    end.

%% Internal callbacks

init(StartFn, Parent) ->
    Debug = sys:debug_options([]),
    handle_start(StartFn(), Parent, Debug).

handle_start(Start, Parent, Debug) ->
    case Start of
        {ready, State} ->
            proc_lib:init_ack(Parent, {ok, self()}),
            loop(State, Parent, Debug);

        {starting, Continuation} ->
            proc_lib:init_ack(Parent, {ok, self()}),
            handle_start(Continuation(), Parent, Debug);

        {failed, Reason} ->
            proc_lib:init_ack(Parent, {error, Reason}),
            terminate(Reason)
    end.


loop(Impl, Parent, Debug) ->
    {Routine, State} = Impl,
    receive
        {system, From, Request} ->
            sys:handle_system_msg(Request, From, Parent, ?MODULE, Debug, Impl);

        {async, Msg} = M ->
            Debug1 = sys:handle_debug(Debug, fun ?MODULE:write_debug/3, ?MODULE, {in, M}),
            handle_next(Routine(State, Msg), Routine, Parent, Debug1);

        {sync, Ref, From, Msg} = M ->
            Debug1 = sys:handle_debug(Debug, fun ?MODULE:write_debug/3, ?MODULE, {in, M}),
            {reply, Reply, Next} = Routine(State, Msg),
            From ! {Ref, Reply},
            Debug2 = sys:handle_debug(Debug1, fun ?MODULE:write_debug/3, ?MODULE, {out, Reply, From}),
            handle_next(Next, Routine, Parent, Debug2)
    end.

handle_next(Next, Routine, Parent, Debug) ->
    case Next of
        {continue, State} -> loop({Routine, State}, Parent, Debug);
        {hibernate, State} -> proc_lib:hibernate(?MODULE, loop, [{Routine, State}]);
        {stop, Reason} -> terminate(Reason);
        {exec, Continuation} -> handle_next(Continuation(), Routine, Parent, Debug)
    end.

% TODO: log error
% https://github.com/erlang/otp/blob/master/lib/stdlib/src/gen_server.erl#L890-L903
terminate(_Reason) ->
  ok.

%% sys module callbacks

system_continue(Parent, Debug, Impl) ->
    loop(Impl, Parent, Debug).

system_terminate(Reason, _Parent, _Debug, _Impl) ->
    exit(Reason).

system_get_state({_Routine, State}) ->
    {ok, State}.

system_replace_state(StateFun, {Routine, State}) ->
    NewState = StateFun(State),
    {ok, NewState, {Routine, NewState}}.

write_debug(Device, Event, Name) ->
    io:format(Device, "~p event = ~p~n", [Name, Event]).
