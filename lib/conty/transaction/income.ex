defmodule Conty.Transaction.Income do
  use Conty.Transaction
  alias Conty.Transaction

  embedded_schema do
    Conty.Transaction.Macros.fields(type: "income")
  end

  def accounts_for_items, do: Conty.list_accounts_by_type(~w(income)a)
  def accounts_for_due, do: Conty.list_accounts_by_type(~w(cash receivable)a)
  def accounts_for_pay, do: Conty.list_accounts_by_type(~w(cash)a)

  def changeset(%Transaction.Income{} = income, attrs) do
    income
    |> cast(attrs, Transaction.casted_fields() ++ [])
    |> cast_assoc(:items)
    |> process_entry
  end

  defp process_entry(changeset) do
    #To create an entry I need
    # account debit (items) and credit (account_due)
    # for each item I create an entry_item
    # for each term I create an entry_item_due
    changeset
  end
end

defimpl Conty.Transactionable, for: Conty.Transaction.Income do
  def cast_from(_transactionable) do
    %Conty.Transaction{}
  end

  def cast_to(_transactionable, %Conty.Transaction{} = _transaction) do
    %Conty.Transaction.Income{
      items: [],
      entry: %Conty.Entry{entry_items: []}
    }
  end
end
