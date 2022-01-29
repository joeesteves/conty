defmodule Conty.EntryItem do
  @moduledoc  false
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, Entry, EntryItem}

  schema "entry_items" do
    field :amount, :decimal

    belongs_to :entry, Entry
    belongs_to :account, Account
  end

  def changeset(%EntryItem{} = entry_item, attrs) do
    entry_item
    |> cast(attrs, [
      :amount,
      :account_id
    ])
    |> validate_required(~w(amount account_id)a)
    |> foreign_key_constraint(:account_id)
  end
end
