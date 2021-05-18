defmodule Conty.Account do
  @moduledoc false
  use Ecto.Schema

  alias Conty.Account

  schema "accounts" do
    field(:name, :string)

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> Ecto.Changeset.cast(attrs, [:name])
  end
end
