-module(hello_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req, State) ->
    %% Enviamos la respuesta "Hello, World!" al cliente
    Reply = <<"Hello, World!">>,
    {ok, Req2} = cowboy_req:reply(200, #{
        <<"content-type">> => <<"text/plain">>
    }, Reply, Req),
    {ok, Req2, State}.