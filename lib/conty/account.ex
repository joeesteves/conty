defmodule Conty.Account do
  use Ecto.Schema

  alias Conty.Account

  @types [{1, :asset}, {2, :liability},  {3, :equity}, {4, :reveneu}, {5, :expense}]

  schema "accounts" do
    field(:name, :string)
    field(:type, :integer)
    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> Ecto.Changeset.cast(attrs, [:name])
    |> validate_inclusion(:type, 1..5)
  end
end
