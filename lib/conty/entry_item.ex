defmodule Conty.EntryItem do
  @moduledoc  """
    The lines in the Journal Entry
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, Entry, EntryItem}

  schema "entry_items" do
    field :amount, :decimal

    belongs_to :entry, Entry
    belongs_to :account, Account

    # i.e. the expense account on a payable entry
    belongs_to :source, Account
  end

  def changeset(%EntryItem{} = entry_item, attrs) do
    entry_item
    |> cast(attrs, [
      :amount,
      :account_id,
      :source_id
    ])
    |> validate_required(~w(amount account_id)a)
  end
end
