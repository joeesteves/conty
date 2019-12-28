defmodule Conty.Account do
  use Ecto.Schema

  alias Conty.Account

  @types [{:cash, 11}, {:receivable, 12}, {:payable, 22}, {:equity, 30}, {:income, 40}, {:outcome, 50}]

  schema "accounts" do
    field(:name, :string)
    field(:type, :integer)

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> Ecto.Changeset.cast(attrs, ~w(name type)a)
    # |> Ecto.Changeset.validate_inclusion(:type, 1..4)
  end

  def type_by_key(key) do
   @types[key]
  end
end
