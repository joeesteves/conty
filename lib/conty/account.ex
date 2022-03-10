defmodule Conty.Account do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, EntryItem, Organization}

  schema "accounts" do
    field(:name, :string)

    belongs_to(:organization, Organization)

    has_many(:entry_items, EntryItem)

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name])
    |> maybe_validate_organization()
  end

  defp maybe_validate_organization(changeset) do
    if Application.get_env(:conty, :use_organization, false) do
      validate_required(changeset, :organization_id)
    else
      changeset
    end
  end
end
