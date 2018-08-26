defmodule RoomBookWeb.Plugs.SetCurrentUser do
  import Plug.Conn

  alias RoomBook.{UserQueries}

  def init(options) do
    options
  end

  def call(conn, _opts) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    cond do
      current_user = user_id && UserQueries.get_by_id(user_id) ->
        conn
        |> assign(:current_user, current_user)
        |> assign(:user_signed_in?, true)
      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
