defmodule Conty.Entry do
  use Ecto.Schema

  alias Conty.{Entry, EntryItem}

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
  end

end
