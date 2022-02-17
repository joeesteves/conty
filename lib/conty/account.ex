defmodule Conty.Account do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, EntryItem}

  schema "accounts" do
    field(:name, :string)

    has_many :entry_items, EntryItem

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:name])
  end
end
