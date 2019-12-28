defmodule Conty.Transaction.Macros do
  defmacro fields(type \\ nil) do
    quote do
      field(:amount, :decimal)
      field(:type, :string, defaul: unquote(type))
      field(:terms, :string)

      field(:account_debit_id, :integer)
      field(:account_credit_id, :integer)
      field(:account_pay_id, :integer)
      # TODO: MAYBE has_many through later to support groups
      belongs_to(:entry, Conty.Entry)
    end
  end
end
