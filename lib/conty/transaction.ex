defmodule Conty.Transaction do
  @moduledoc """
    type is the name of the module transactionable string
  """
  use Ecto.Schema
  alias Conty.Transaction
  import Ecto.Changeset

  require Conty.Transaction.Macros

  schema "transactions" do
    field(:date, :date)
    field(:due_base_date, :date)
    field(:amount, :decimal)
    field(:type, :string)
    field(:terms_generator, :string)

    field(:terms, {:array, :map})

    belongs_to(:account_due, Conty.Account)
    belongs_to(:account_pay, Conty.Account)
    # TODO: MAYBE has_many through later to support groups
    belongs_to(:entry, Conty.Entry)

    if organization = Application.get_env(:conty, :options)[:organization_module] do
      belongs_to(:organization, organization)
    end

    has_many(:items, Conty.TransactionItem, foreign_key: :transaction_id)
  end

  @callback changeset(transaction :: term, attrs :: term) :: term
  @callback accounts_for_items() :: [term]
  @callback accounts_for_due() :: [term]
  @callback accounts_for_pay() :: [term]
  def changeset(%Transaction{} = transaction, attrs) do
    IO.inspect attrs
    transaction
    |> cast(attrs, casted_fields())
    |> cast_assoc(:entry)
    |> cast_assoc(:items)
  end

  defp casted_fields do
    ~w(date due_base_date amount type terms_generator account_due_id account_pay_id)a
  end

  def casted_fields_flattened do
    casted_fields() ++ ~w(items)a
  end
  def cast_from(transactionable) do
    Conty.Transactionable.cast_from(transactionable)
  end

  def cast_to(transactionable, %Conty.Transaction{} = transaction) do
    Conty.Transactionable.cast_to(transactionable, transaction)
  end

  def cast_to_type(%Conty.Transaction{type: type} = transaction) do
    type = String.capitalize(type)
    target_module = String.to_existing_atom("Elixir.Conty.Transaction." <> type)
    target_struct = apply(target_module, :__struct__, [])

    apply(__MODULE__, :cast_to, [target_struct, transaction])
  end

  defmacro __using__(_opts) do
    quote do
      @behaviour Conty.Transaction

      use Ecto.Schema
      import Ecto.Changeset
      require Conty.Transaction.Macros
    end
  end
end

defprotocol Conty.Transactionable do
  @spec cast_from(any) :: %Conty.Transaction{}
  def cast_from(transactionable)

  @spec cast_to(any, %Conty.Transaction{}) :: any
  def cast_to(transactionable, transaction)
end
