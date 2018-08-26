defmodule RoomBookWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias RoomBookWeb.Router.Helpers

  def init(options) do
    options
  end

  def call(conn, _opts) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end
end
