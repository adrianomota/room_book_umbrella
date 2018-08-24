use Mix.Config

config :room_book, RoomBook.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "room_book_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5432,
  pool_size: 10
