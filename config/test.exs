use Mix.Config

config :conty, Conty.Repo,
  database: "conty_test",
  username: "postgres",
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
