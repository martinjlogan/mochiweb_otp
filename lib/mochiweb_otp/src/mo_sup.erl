%%%-------------------------------------------------------------------
%%% @author Martin Logan <martinjlogan@Macintosh.local>
%%% @copyright (C) 2010, Martin Logan
%%% @doc
%%%
%%% @end
%%% Created : 25 Jan 2010 by Martin Logan <martinjlogan@Macintosh.local>
%%%-------------------------------------------------------------------
-module(mo_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, upgrade/0, start_child/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervisor
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%--------------------------------------------------------------------
%% @doc Start up a new child process
%% @spec start_child(Options) -> ok.
%% @end
%%--------------------------------------------------------------------
start_child(Options) ->
    supervisor:start_child(?MODULE, [Options]).

%%--------------------------------------------------------------------
%% @doc Add processes if necessary.
%% @spec upgrade() -> ok
%% @end
%%--------------------------------------------------------------------
upgrade() ->
    {ok, {_, Specs}} = init([]),
    [supervisor:start_child(?MODULE, Spec) || Spec <- Specs],
    ok.

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
%%
%% @spec init(Args) -> {ok, {SupFlags, [ChildSpec]}} |
%%                     ignore |
%%                     {error, Reason}
%% @end
%%--------------------------------------------------------------------
init([]) ->
    AChild = {mochiweb_http, {mochiweb_http,start,[]},
	      permanent,2000,worker,[mochiweb_http]},
    {ok,{{simple_one_for_one,0,1}, [AChild]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

