defmodule Conty.EntryItem do
  use Ecto.Schema

  alias Conty.{Entry, EntryItem}

  schema "entry_items" do
    field :amount, :decimal

    belongs_to :entry, Entry
  end

  def changeset(%EntryItem{} = entry_item, attrs) do
    entry_item
    |> Ecto.Changeset.cast(attrs, [
      :amount
    ])
  end
end
