defmodule RoomBook.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias RoomBook.User

  schema "users" do
    field(:email, :string, null: false)
    field(:username, :string, null: false)
    field(:encrypted_password, :string, null: false)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    has_many(:rooms, RoomBook.Room)
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
    |> validate_length(:username, min: 3, max: 30)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  @doc false
  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> validate_confirmation(:password)
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 6, max: 128)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
