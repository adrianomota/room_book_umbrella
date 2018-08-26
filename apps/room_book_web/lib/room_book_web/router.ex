defmodule RoomBookWeb.Router do
  use RoomBookWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(RoomBookWeb.Plugs.SetCurrentUser)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", RoomBookWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/room", RoomController)

    resources("/session", SessionController, only: [:new, :create])

    delete("/sign_out", SessionController, :delete)

    resources("/registration", RegistrationController, only: [:new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", RoomBookWeb do
  #   pipe_through :api
  # end
end
