defmodule Conty.Application do
  @moduledoc false
   use Application

  def start(_type, _args) do
    children = [
      Conty.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Conty.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
