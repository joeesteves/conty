defmodule Conty.Transaction.Macros do
  defmacro fields(type \\ nil) do
    quote do
      field(:amount, :decimal)
      field(:type, :string, defaul: unquote(type))
      field(:term_generator, :string)

      belongs_to(:account_due_id, Conty.Account)
      belongs_to(:account_pay_id, Conty.Account)
      # TODO: MAYBE has_many through later to support groups
      belongs_to(:entry, Conty.Entry)

      has_many(:items, Conty.TransactionItem)
      has_many(:terms, Conty.Term)
    end
  end
end
