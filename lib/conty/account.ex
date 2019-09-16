defmodule Conty.Account do
  use Ecto.Schema

  alias Conty.Account

  schema "accounts" do
    field(:name, :date)

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> Ecto.Changeset.cast(attrs, [:name])
  end
end
