%%%-------------------------------------------------------------------
%%% @author Martin Logan <martinjlogan@Macintosh.local>
%%% @copyright (C) 2010, Martin Logan
%%% @doc
%%%  This is the index for our webapp test
%%% @end
%%% Created : 23 Jan 2010 by Martin Logan <martinjlogan@Macintosh.local>
%%%-------------------------------------------------------------------
-module(mo_index).

%% API
-export([handle/1]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc This handles http requests
%% @spec (Req) -> void()
%% @end
%%--------------------------------------------------------------------
handle(Req) ->
    Body = "The Erlware Mochiweb Release wrapper is now up and running. "
   	   "Check out the Erlware Mochiweb made Simple Tutorial screencast "
	   "at Erlware.org for instructions on how to rapidly create "
           "your own OTP complient web apps with Mochiweb and some "
	   "help from the Erlware tools",
    Req:respond({200, [{"content-type", "text/plain"}], Body}).

%%%===================================================================
%%% Internal functions
%%%===================================================================
