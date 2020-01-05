defmodule Conty.Transaction.Income do
  use Conty.Transaction
  alias Conty.Transaction
  alias Decimal, as: D

  embedded_schema do
    Conty.Transaction.Macros.fields(type: "income")
  end

  def accounts_for_items, do: Conty.list_accounts_by_type(~w(income)a)
  def accounts_for_due, do: Conty.list_accounts_by_type(~w(cash receivable)a)
  def accounts_for_pay, do: Conty.list_accounts_by_type(~w(cash)a)

  def changeset(%Transaction.Income{} = income, attrs) do
    income
    |> cast(attrs, Transaction.casted_fields_flattened() ++ [])
    |> build
  end

  defp build(changeset) do
    #To create an entry I need
    # account debit (items) and credit (account_due)
    # for each item I create an entry_item
    # for each term I create an entry_item_due
    case get_change(changeset, :items) do
      nil ->
        changeset
      items ->
        totalize_items(changeset, items)
        |> build_terms
      end
  end

  defp build_terms(changeset) do
    change(changeset, %{terms: Conty.Term.generate(apply_changes(changeset))})
  end

  defp totalize_items(changeset, items) do
    amount = Enum.reduce(items, D.cast(0), fn x, acc ->
      D.add(D.cast(x.amount), acc)
    end)

    change(changeset, %{amount: amount})
  end
end

defimpl Conty.Transactionable, for: Conty.Transaction.Income do
  alias Conty.Transaction.Income
  alias Conty.Transaction
  def cast_from(_transactionable) do
    %Conty.Transaction{}
  end

  def cast_to(_transactionable, %Transaction{} = transaction) do
    income = %Income{} |> Map.merge(transaction)
    items = transaction.items |> Enum.map(&Map.from_struct/1)

    Map.put(income, :items, items)
  end
end
