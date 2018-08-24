defmodule RoomBook.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias RoomBook.Room

  schema "rooms" do
    field(:name, :string, null: false, size: 25)
    field(:description, :string, size: 1000)
    field(:topic, :string, size: 100)

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :description, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 3, max: 25)
    |> validate_length(:topic, min: 5, max: 100)
  end
end
