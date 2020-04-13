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
    |> validate_required([:company_id])
  end

  def build(income) do
    income
    |> totalize_items
    |> build_terms
  end

  defp build_terms(income) do
    terms = Conty.Term.generate(income, -1)

    %{income | terms: terms}
  end

  defp totalize_items(income) do
    amount =
      Enum.reduce(income.items, D.cast(0), fn x, acc ->
        D.add(D.cast(x.amount), acc)
      end)

    %{income | amount: amount}
  end
end

defimpl Conty.Transactionable, for: Conty.Transaction.Income do
  alias Conty.Transaction.Income
  alias Conty.Transaction

  def cast_from(transactionable) do
    income_attrs =
      Map.from_struct(transactionable)
      |> build_entry()

    Transaction.changeset(%Transaction{}, income_attrs)
    |> Ecto.Changeset.apply_changes()
  end

  defp build_entry(income_attrs) do
    income_items = income_attrs.items
    due_items = income_attrs.terms

    entry_items =
      for item <- income_items ++ due_items do
        %{due: Map.get(item, :date), amount: item.amount, account_id: item.account_id, company_id: Map.get(item, :company_id)}
      end

    entry_attrs = %{
      date: Date.utc_today(),
      description: "HELLO WORLD",
      items: entry_items
    }

    Map.put(income_attrs, :entry, entry_attrs)
  end

  def cast_to(_transactionable, %Transaction{} = transaction) do

    income = Map.merge(transaction, %Income{})

    items = transaction.items |> Enum.map(&Map.from_struct/1)

    Map.put(income, :items, items)
  end
end
