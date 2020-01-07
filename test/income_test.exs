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
          account_due_id: account(:receivable),
          account_pay_id: account(:cash),
          company_id: company(),
          items: [
            %{
              amount: 100,
              account_id: account(:income)
            }
          ]
        }
        |> Income.build()
        |> Conty.Transaction.cast_from()
        |> Conty.Repo.insert

        IO.inspect(income)
    end
  end

  def seeds(_context) do
    payable = Conty.Account.type_by_key(:payable)
    receivable = Conty.Account.type_by_key(:receivable)
    income = Conty.Account.type_by_key(:income)
    bank = Conty.Account.type_by_key(:cash)

    [
      %{name: "Income", type: income},
      %{name: "Payable", type: payable},
      %{name: "Reiceivable", type: receivable},
      %{name: "Bank", type: bank}
    ]
    |> Enum.each(fn account -> Conty.create_account(account) end)

    # Create Company for transactions
    %Conty.Company{id: 1, name: "The Buyer"} |> Conty.Repo.insert!

    :ok
  end

  def account(key) do
   Conty.list_accounts_by_type([key])
   |> List.first()
   |> Map.get(:id)
  end
  def company, do: Conty.Company |> Repo.all |> List.first() |> Map.get(:id)
end
