defmodule Conty.Repo do
  use Ecto.Repo,
    otp_app: :conty,
    adapter: Ecto.Adapters.Postgres
end
