defmodule Conty.Account do
  use Ecto.Schema

  alias Conty.Account

  @types [{1, :cash}, {2, :due},  {3, :equity}, {4, :result}]

  schema "accounts" do
    field(:name, :string)
    field(:type, :integer)

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> Ecto.Changeset.cast(attrs, ~w(name type tags)a)
    |> Ecto.Changeset.validate_inclusion(:type, 1..5)
  end
end
