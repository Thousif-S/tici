defmodule TiciWeb.Router do
  use TiciWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug TiciWeb.Plugs.SetCurrentUser
  end

  # scope "/api", TiciWeb do
  #   pipe_through :api
  # end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: TiciWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: TiciWeb.Schema.Schema,
      socket: TiciWeb.UserSocket,
      interface: :simple
  end
end
