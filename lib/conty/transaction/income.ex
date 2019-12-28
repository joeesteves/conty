defmodule Conty.Transaction.Income do
  use Conty.Transaction

  embedded_schema do
    Conty.Transaction.Macros.fields()
    # field :extend_transaccion_wth_fields_desc, :string
  end

  def changeset(%Conty.Transaction.Income{} = income, attrs) do
    Ecto.Changeset.cast(income, attrs, [:type, :terms])
  end
end

defimpl Conty.Transactionable, for: Conty.Transaction.Income do
  def cast_from(_transactionable) do
    %Conty.Transaction{}
  end

  def cast_to(transactionable, %Conty.Transaction{} = _transaction) do
    transactionable
  end
end
