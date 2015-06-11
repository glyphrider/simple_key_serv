-module(user_resource).

-export([init/1,allowed_methods/2,content_types_provided/2,to_text_plain/2,resource_exists/2,content_types_accepted/2,from_text_plain/2]).

-include_lib("webmachine/include/webmachine.hrl").

init(_RouteArgs) ->
    {ok,undefined}.

allowed_methods(ReqData,State) ->
    {['GET','HEAD','OPTIONS','PUT'],ReqData,State}.

content_types_provided(ReqData,State) ->
    {[{"text/plain",to_text_plain}],ReqData,State}.

resource_exists(ReqData,State) ->
    resource_exists(ReqData,State,wrq:method(ReqData)).

resource_exists(ReqData,State,'PUT') ->
    {true,ReqData,State};
resource_exists(ReqData,_State,'GET') ->
    Keys = user_storage:user_key(wrq:path_info(username,ReqData)),
    { Keys =/= [],ReqData,Keys }.

to_text_plain(ReqData,State) ->
    {hd(State),ReqData,State}.

content_types_accepted(ReqData,State) ->
    {[{"text/plain",from_text_plain}],ReqData,State}.

from_text_plain(ReqData,State) ->
    Key = wrq:req_body(ReqData),
    Name = wrq:path_info(username,ReqData),
    user_storage:user_key(Name,Key),
    {ok,ReqData,State}.
