defmodule Conty.TransactionItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transaction_items" do
    field :amount, :decimal
    field :description, :string

    belongs_to :account, Conty.Account
    belongs_to :transaction, Conty.Transaction
  end

  def changeset(%Conty.TransactionItem{} = item, attrs) do
    item
    |> cast(attrs, [:amount, :description, :account_id, :transaction_id])
    |> validate_required([:amount])
  end
end
