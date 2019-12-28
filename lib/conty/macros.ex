defmodule Conty.Transaction.Macros do
  defmacro fields(type \\ nil) do
    quote do
      field(:date, :date)
      field(:due_base_date, :date)
      field(:amount, :decimal)
      field(:type, :string, defaul: unquote(type))
      field(:term_generator, :string)

      belongs_to(:account_due_id, Conty.Account)
      belongs_to(:account_pay_id, Conty.Account)
      # TODO: MAYBE has_many through later to support groups
      belongs_to(:entry, Conty.Entry)

      has_many(:items, Conty.TransactionItem, foreign_key: :transaction_id)
      has_many(:terms, Conty.Term, foreign_key: :transaction_id)
    end
  end
end
