-module(key_serv_resource).
-export([
    init/1,
    to_html/2
]).

-include_lib("webmachine/include/webmachine.hrl").

-spec init(list()) -> {ok, term()}.
init([]) ->
    {ok, undefined}.

-spec to_html(wrq:reqdata(), term()) -> {iodata(), wrq:reqdata(), term()}.
to_html(ReqData, State) ->
    {"<html><head><title>Simple Key Storage</title></head><body><p>Simple Key Storage, FTW!</p></body></html>", ReqData, State}.

