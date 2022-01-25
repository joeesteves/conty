defmodule Conty.Entry do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

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
    |> cast(attrs, [
      :date,
      :description
    ])
    |> cast_assoc(:entry_items)
    |> validate_balance
  end

  def validate_balance(changeset) do
    validate_change(changeset, :entry_items, fn _, _ ->
      items = apply_changes(changeset).entry_items

      if entry_balanced?(items), do: [], else: [base: "not balanced"]
    end)
  end


  defp entry_balanced?(items) do
    Enum.map(items, & &1.amount)
    |> Enum.reduce(D.new(0), &D.add(&1, &2)) == D.new(0)
  end
end
