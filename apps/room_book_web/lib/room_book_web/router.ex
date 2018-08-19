defmodule RoomBookWeb.Router do
  use RoomBookWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RoomBookWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/room", RoomBookController

    # gets
    #get "/room", RoomBookController, :index
    #get "/room/new", RoomBookController, :new
    #get "/room/:id", RoomBookController, :show
    #get "/room/:id/edit", RoomBookController, :edit

    #posts
    #post "/room", RoomBookController, :create

    #puts
    #put "/room/:id", RoomBookController, :update

    #deletes
    #delete "/room/:id", RoomBookController, :delete

  end

  # Other scopes may use custom stacks.
  # scope "/api", RoomBookWeb do
  #   pipe_through :api
  # end
end
