defmodule Conty.Transaction do
  @moduledoc """
    type is the name of the module transactionable string
  """

  use Ecto.Schema
  import Ecto.Changest
  alias Conty.Transaction

  schema "transactions" do
    field :type, :string
    field :terms, :string

    # TODO: MAYBE has_many through later to support groups
    belongs_to :entry, Conty.Entry
  end

  def changeset(%Transaction{} = transaction, attrs \\ %{}) do
    transaction
    |> cast(attrs, [:type, :terms])
    |> cast_assoc(:entry)
  end

  def cast(transactionable) do
    Conty.Transactionable.cast(transactionable)
  end

  def cast(transactionable, %Conty.Transaction{} = transaction) do
    Conty.Transactionable.cast(transactionable, transaction)
  end
end

defprotocol Conty.Transactionable do
  @type transactionable :: %{type: String.t, terms: String.t}

  @spec cast(any) :: %Conty.Transaction{}
  def cast(transactionable)

  @spec cast(transactionable, %Conty.Transaction{}) :: transactionable
  def cast(transactionable, transaction)
end
