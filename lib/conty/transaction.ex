defmodule Conty.Transaction do
  @moduledoc """
    type is the name of the module transactionable string
  """
  use Ecto.Schema
  alias Conty.Transaction

  require Conty.Transaction.Macros

  schema "transactions" do
    Conty.Transaction.Macros.fields()
  end

  @callback changeset(transaction :: term , attrs :: term) :: term
  @callback accounts_debit() :: [term]
  @callback accounts_credit() :: [term]
  @callback accounts_pay() :: [term]
  def changeset(%Transaction{} = transaction, attrs) do
    transaction
    |> Ecto.Changeset.cast(attrs, required_fields())
    |> Ecto.Changeset.cast_assoc(:entry)
  end

  def required_fields do
    ~w(type terms)a
  end
  def cast_from(transactionable) do
    Conty.Transactionable.cast_from(transactionable)
  end

  def cast_to(transactionable, %Conty.Transaction{} = transaction) do
    Conty.Transactionable.cast_to(transactionable, transaction)
  end

  def cast_to_by_type(%Conty.Transaction{type: type} = transaction) do
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
  @type transactionable :: %{type: String.t, terms: String.t}

  @spec cast_from(any) :: %Conty.Transaction{}
  def cast_from(transactionable)

  @spec cast_to(transactionable, %Conty.Transaction{}) :: transactionable
  def cast_to(transactionable, transaction)
end
