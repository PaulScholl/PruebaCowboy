-module(name_handler).
-behaviour(cowboy_handler).

-export([init/2]).

init(Req, State) ->
    %% Extraer el parámetro `id` de la ruta
    Name = cowboy_req:binding(name, Req),

    %% Enviar la respuesta con el valor de nombre
    {ok, Req2} = cowboy_req:reply(200, #{
        <<"content-type">> => <<"text/plain">>
    }, <<"¡Bienvenido/a: ", Name/binary," !">>, Req),
    
    {ok, Req2, State}.

