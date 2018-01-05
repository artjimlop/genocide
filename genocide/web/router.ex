defmodule Genocide.Router do
  use Genocide.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Genocide do
    pipe_through :api
  end

  scope "/", Genocide do
    pipe_through :api
    
    resources "/users", UserController
  end
end
