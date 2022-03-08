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

  schema "organizations" do
    field(:name, :string)

    timestamps()
  end

  def changeset(%Conty.Organization{} = organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
