defmodule Conty.Transaction.Macros do
  defmacro fields(opts \\ []) do
    quote do
      field(:date, :date)
      field(:due_base_date, :date)
      field(:amount, :decimal)
      field(:type, :string, defaul: unquote(opts[:type]))
      field(:terms_generator, :string)

      belongs_to(:account_due, Conty.Account)
      belongs_to(:account_pay, Conty.Account)
      # TODO: MAYBE has_many through later to support groups
      belongs_to(:entry, Conty.Entry)

      if organization = Application.get_env(:conty, :options)[:organization_module] do
        belongs_to(:organization, organization)
      end

      has_many(:items, Conty.TransactionItem, foreign_key: :transaction_id)
      has_many(:terms, Conty.Term, foreign_key: :transaction_id)
    end
  end
end
