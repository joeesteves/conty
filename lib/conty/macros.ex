defmodule Conty.Transaction.Macros do
  defmacro fields(opts \\ []) do
    quote do
      field(:date, :date)
      field(:due_base_date, :date)
      field(:amount, :decimal)
      field(:type, :string, default: unquote(opts[:type]))
      field(:terms_generator, :string)

      # Lite Belongs To
      field(:account_due_id, :integer)
      field(:account_pay_id, :integer)
      field(:organization_id, :integer)
      field(:company_id, :integer)

      # Lite Has Many
      field(:items, {:array, :map}, default: [])
      field(:terms, {:array, :map}, default: [])
    end
  end
end
