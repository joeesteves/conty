defmodule Conty.Transaction.Income do
  use Conty.Transaction
  alias Conty.Transaction

  embedded_schema do
    Conty.Transaction.Macros.fields("income")
  end

  def changeset(%Transaction.Income{} = income, attrs) do
    income
    |> cast(attrs, Transaction.casted_fields() ++ [])
    |> cast_assoc(:entry)
  end

  def accounts_for_items, do: Conty.list_accounts_by_type(~w(income)a)
  def accounts_for_due, do: Conty.list_accounts_by_type(~w(cash receivable)a)
  def accounts_for_pay, do: Conty.list_accounts_by_type(~w(cash)a)
end

defimpl Conty.Transactionable, for: Conty.Transaction.Income do
  def cast_from(_transactionable) do
    %Conty.Transaction{}
  end

  def cast_to(transactionable, %Conty.Transaction{} = _transaction) do
    transactionable
  end
end
