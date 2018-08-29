defmodule RoomBook.UserQueries do
  import Ecto.Query
  alias RoomBook.{Repo, User}

  def get_all do
    Repo.all(from(User))
  end

  def get_by_id(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def get_all_for_email(email) do
    query =
      from(u in User,
        where: u.email == ^email
      )

    Repo.all(query)
  end

  def any do
    Repo.one(from(user in User, select: count(user.id))) != 0
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_room(%User{} = user) do
    user
    |> Repo.delete()
  end
end
