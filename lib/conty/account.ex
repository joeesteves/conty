defmodule Conty.Account do
  use Ecto.Schema

  alias Conty.Account

  @types [{:cash, 1}, {:due, 2},  {:equity, 3}, {:result, 4}]

  schema "accounts" do
    field(:name, :string)
    field(:type, :integer)

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> Ecto.Changeset.cast(attrs, ~w(name type)a)
    |> Ecto.Changeset.validate_inclusion(:type, 1..4)
  end

  def type_by_key(key) do
   @types[key]
  end
end
