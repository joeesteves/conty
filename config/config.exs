use Mix.Config

config :conty, Conty.Repo,
  database: "conty_dev",
  username: "postgres",
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: "localhost"

config :conty, ecto_repos: [Conty.Repo]

import_config "#{Mix.env()}.exs"
