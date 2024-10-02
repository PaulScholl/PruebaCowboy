-module(cowboy_app_app).
-behaviour(application).

%% API
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    %%Dispatch es el objeto que se encargará de llamar al modulo dependiendo la ruta que se mencione
    Dispatch = cowboy_router:compile([
        {'_', [
            %%Los parametros de los objetos en orden son:  [ruta],[modulo a procesar],[opciones]
            {"/", hello_handler, []},
            %%Ya que queremos mandar un parametro dinamico al modulo de name_handler
            %%deberemos agregar la ruta junto con "/[la informacion que mandaremos]"
            {"/saludo/:name", name_handler,[]}
        ]}
    ]),
    %%Enviamos a Cowboy el dispatch y que funcione en el puerto 8080
    {ok, _} = cowboy:start_clear(http_listener, [{port, 8080}], #{
        env => #{dispatch => Dispatch}
    }),
    cowboy_app_sup:start_link().

stop(_State) ->
    ok.