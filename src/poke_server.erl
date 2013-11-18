-module(poke_server).
-behaviour (gen_server).

-export([poke/0,numberOfPokes/0]).

-export([start_link/0,init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]).

-record(state,{numberOfPokes = 0}).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
	{ok,#state{}}.

poke() -> 
	gen_server:call(?MODULE,poke).

numberOfPokes() ->
	gen_server:call(?MODULE,numberOfPokes).

% Callbacks

%handle_call(Atom, From, State) ->
handle_call(poke, _, State) ->
	NewNumberOfPokes = State#state.numberOfPokes+1,
	NewState = State#state{numberOfPokes = NewNumberOfPokes},
	Reply = {ok, NewNumberOfPokes},
    {reply, Reply, NewState};

handle_call(numberOfPokes, _, State) ->
	Reply = State#state.numberOfPokes,
    {reply, Reply, State}.

%handle_cast(Msg, State) ->
handle_cast(_, State) ->
    {noreply, State}.

%handle_info(Info, State) ->
handle_info(_, State) ->
    {noreply, State}.

%terminate(Reason, State) ->
terminate(_, _) ->
    ok.

%code_change(OldVsn, State, Extra) ->
code_change(_, State, _) ->
    {ok, State}.