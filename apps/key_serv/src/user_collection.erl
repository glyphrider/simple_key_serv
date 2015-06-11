-module(user_collection).

-export([init/1,allowed_methods/2,content_types_provided/2,to_text_plain/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(_RouteArguments) ->
    {ok,undefined}.

allowed_methods(ReqData,State) ->
    {['GET','HEAD','OPTIONS'],ReqData,State}.

content_types_provided(ReqData,State) ->
    {[{"text/plain",to_text_plain}],ReqData,State}.

to_text_plain(ReqData,State) ->
    {all_users(),ReqData,State}.

%%% Private Functions

all_users() ->
    lists:foldl(fun(User,Acc) ->
			Acc ++ io_lib:format("~s~n",[User])
		end,[],user_storage:all_users()).
			  
