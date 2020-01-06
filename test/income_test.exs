defmodule TransactionIncomeTest do
  use Conty.DataCase
  alias Conty.Transaction.{Income}
  alias Conty.TransactionItem

  setup :seeds

  describe "Income" do
    test "1 term" do
      income =
        %Income{
          date: Date.utc_today(),
          due_base_date: Date.utc_today(),
          terms_generator: "0",
          account_due_id: 3,
          account_pay_id: 4,
          items: [
            %{
              amount: 100,
              account_id: 1
            }
          ]
        }
        |> Income.build()
        |> Conty.Transaction.cast_from()

      assert income == [%{}]
    end
  end

  def seeds(_context) do
    payable = Conty.Account.type_by_key(:payable)
    receivable = Conty.Account.type_by_key(:receivalbe)
    income = Conty.Account.type_by_key(:income)
    bank = Conty.Account.type_by_key(:bank)

    [
      %{id: 1, name: "Income", type: income},
      %{id: 2, name: "Payable", type: payable},
      %{id: 3, name: "Reiceivable", type: receivable},
      %{id: 4, name: "Bank", type: bank}
    ]
    |> Enum.each(fn account -> Conty.create_account(account) end)

    :ok
  end
end
