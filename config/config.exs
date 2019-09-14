use Mix.Config

config :conty, Conty.Repo,
  database: "conty_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  # OR use a URL to connect instead
  url: "postgres://postgres:postgres@localhost/ecto_simple"

config :conty, ecto_repos: [Conty.Repo]
