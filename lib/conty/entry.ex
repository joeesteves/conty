defmodule Conty.Entry do
  use Ecto.Schema

  alias Conty.{Entry, EntryItem}
  alias Decimal, as: D

  schema "entries" do
    field :date, :date
    field :description, :string

    has_many :entry_items, EntryItem

    timestamps()
  end

  def changeset(%Entry{} = entry, attrs) do
    entry
    |> Ecto.Changeset.cast(attrs, [
      :date,
      :description
    ])
    |> Ecto.Changeset.cast_assoc(:entry_items)
    |> validate_balance
  end

  def validate_balance(changeset) do
    Ecto.Changeset.validate_change(changeset, :entry_items, fn _, _ ->
      items = Ecto.Changeset.apply_changes(changeset).entry_items
      cond do
        (Enum.map(items, &(Map.get(&1, :amount))) |> Enum.reduce(D.new(0), &D.add(&1, &2))) == D.new(0) -> []
        true -> [error: "bad balance"]
      end
    end)
  end
end