defmodule Conty.EntryItem do
  @moduledoc """
    The lines in the Journal Entry
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, Entry}

  schema "entry_items" do
    field(:amount, :decimal)
    field(:due_date, :date)

    field(:side, Ecto.Enum, values: [:debit, :credit])

    belongs_to(:entry, Entry)
    belongs_to(:account, Account)

    # i.e. the expense account on a payable entry
    belongs_to(:source, Account)
  end

  def changeset(%__MODULE__{} = entry_item, attrs) do
    entry_item
    |> cast(attrs, [
      :amount,
      :account_id,
      :source_id
    ])
    |> validate_required(~w(amount account_id)a)
  end
end
