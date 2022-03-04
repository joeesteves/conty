defmodule Conty.Organization do
  @moduledoc """
  Is optional to use Organizations but recommended.
  Organizations owns accountability, entries and accounts belongs to them.
  Conty supports multiple organizacions.
  This play well with any phoenix app, with auth_gen doing minor tweeks.
  Usually User <-> Role <-> Organization
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Entry, EntryItem}
  alias Decimal, as: D

  schema "organizations" do
    field(:name, :string)

    has_many(:entries, Entry)

    timestamps()
  end

  def changeset(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [:name])
    |> validate_required(attrs, [:name])
  end
end
