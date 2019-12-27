defmodule Conty.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Conty.Repo

      import Ecto
      import Ecto.Query
      import Conty.DataCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Conty.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Conty.Repo, {:shared, self()})
    end

    :ok
  end
end
