%%%----------------------------------------------------------------
%%% @author Martin J. Logan <martinjlogan@erlware.org>
%%% @doc
%%%
%%% @end
%%% @copyright 2010 Martin J. Logan
%%%----------------------------------------------------------------,
-module(mo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%%===================================================================
%%% Application callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called whenever an application is started using
%% application:start/[1,2], and should start the processes of the
%% application. If the application is structured according to the OTP
%% design principles as a supervision tree, this means starting the
%% top supervisor of the tree.
%%
%% @spec start(StartType, StartArgs) -> {ok, Pid} |
%%                                      {ok, Pid, State} |
%%                                      {error, Reason}
%%      StartType = normal | {takeover, Node} | {failover, Node}
%%      StartArgs = term()
%% @end
%%--------------------------------------------------------------------
start(_StartType, _StartArgs) ->
    {ok, Pid} = mo_sup:start_link(),
    case application:get_env(mochiweb_otp, instances) of
	undefined ->
	    ok;
	{ok, Instances} ->
	    lists:foreach(fun(Options) ->
				  mo_sup:start_child(Options)
			  end,
			  Instances)
    end,
    {ok, Pid}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called whenever an application has stopped. It
%% is intended to be the opposite of Module:start/2 and should do
%% any necessary cleaning up. The return value is ignored.
%%
%% @spec stop(State) -> void()
%% @end
%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================


