defmodule Conty.EntryItem do
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, Entry, EntryItem}

  schema "entry_items" do
    field :amount, :decimal
    field :due, :date

    belongs_to :entry, Entry
    belongs_to :account, Account
  end

  def changeset(%EntryItem{} = entry_item, attrs) do
    entry_item
    |> cast(attrs, [
      :due,
      :amount,
      :account_id
    ])
    |> foreign_key_constraint(:account_id)
  end
end
