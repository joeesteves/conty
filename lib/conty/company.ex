defmodule Conty.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string

    has_many :transactions, Conty.Transaction
  end

  def changeset(%Conty.Company{} = company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
