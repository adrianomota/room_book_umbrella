defmodule RoomBookWeb.RoomController do
  use RoomBookWeb, :controller
  alias RoomBook.{RoomQueries, Room}

  plug RoomBookWeb.Plugs.AuthenticateUser when action not in [:index]

  plug :authorize_user when action in [:edit, :update, :delete]

  def index(conn, _params) do
    rooms = RoomQueries.get_all()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = RoomQueries.change_room(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    room = RoomQueries.get_by_id(id)
    render(conn, "show.html", room: room)
  end

  def create(conn, %{"room" => room_params}) do
    case RoomQueries.create_room(conn.assigns.current_user,room_params) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: room_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    room = RoomQueries.get_by_id(id)
    changeset = RoomQueries.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = RoomQueries.get_by_id(id)

    case RoomQueries.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = RoomQueries.get_by_id(id)

    case RoomQueries.delete_room(room) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room deleted successfully.")
        |> redirect(to: room_path(conn, :index))
    end
  end

  defp authorize_user(conn, _params) do
    %{params: %{"id" => room_id}} = conn
    room = RoomQueries.get_by_id(room_id)
    if RoomBookWeb.Auth.can_manage?(conn.assigns.current_user, room) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access that page")
      |> redirect(to: room_path(conn, :index))
      |> halt()
    end
  end
end
