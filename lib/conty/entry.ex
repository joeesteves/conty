defmodule Conty.Entry do
  @moduledoc false
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

      if entry_balanced?(items), do: [], else: [error: "bad balance"]
    end)
  end


  defp entry_balanced?(items) do
    Enum.map(items, & &1.amount)
    |> Enum.reduce(D.new(0), &D.add(&1, &2)) == D.new(0)
  end
end
