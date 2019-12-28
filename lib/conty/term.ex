defmodule Conty.Term do
  use Ecto.Schema

  schema "terms" do
    field(:date, :date)
    field(:percern, :decimal)

    belongs_to(:transaction, Conty.Transaction)
  end
end
