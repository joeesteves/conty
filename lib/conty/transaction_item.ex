defmodule Conty.TransactionItem do
  use Ecto.Schema

  schema "transaction_items" do
    field :amount, :decimal
    field :description, :string

    belongs_to :account, Conty.Account
    belongs_to :transaction, Conty.Transaction

  end
end
