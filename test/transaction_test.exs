defmodule TransactionTest do
  use Conty.DataCase
  alias Conty.Transaction
  alias Conty.Transaction.Income

  describe "transactionable protocol" do
    test ".cast_from" do
      result = Transaction.cast_from(%Income{})
      assert %Transaction{} = result
    end

    test ".cast_to/2" do
      result = Transaction.cast_to(%Income{}, %Transaction{items: []})
      assert %Income{} = result
    end

    test ".cast_to_by_type/1" do
      # Helper infers type from Transaction and calls cast_to/2 👆

      result = Transaction.cast_to_type(%Transaction{type: "income", items: []})
      assert %Income{} = result
    end
  end
end
