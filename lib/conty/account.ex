defmodule Conty.Account do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias Conty.{Account, EntryItem, Organization}

  schema "accounts" do
    field(:name, :string)

    belongs_to :organization, Organization

    has_many :entry_items, EntryItem

    timestamps()
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:name])
  end
end
