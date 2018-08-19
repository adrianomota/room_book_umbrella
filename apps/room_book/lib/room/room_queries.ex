defmodule RoomBook.RoomQueries do
    import Ecto.Query
    alias RoomBook.{Repo,Room}

    def get_all do
        Repo.all(from Room)
    end

    def get_by_id(id) do
      Repo.get!(Room, id)
    end

    def get_room_by(params) do
      Repo.get_by!(Room, params)
    end

    def create_room(attrs \\ %{}) do
      %Room{}
        |> Room.changeset(attrs)
        |> Repo.insert
    end

    def update_room(%Room{} = room, attrs) do
       room
        |> Room.changeset(attrs)
        |> Repo.update
    end

    def delete_room(%Room{} = room) do
        room
        |> Repo.delete
    end

    def any do
      Repo.one(from room in Room, select: count(room.id)) != 0
    end

    def change_room(%Room{} = room) do
        Room.changeset(room, %{})
    end
end
