defmodule ContyTest do
  use Conty.DataCase

  alias Conty.Account

  setup :seeds

  describe "accounts" do
    test ".list_account_by_type" do
      assert Conty.list_accounts_by_type([:cash]) |> length == 1
      assert Conty.list_accounts_by_type([:receivable, :payable]) |> length == 2
      assert Conty.list_accounts_by_type([:payable]) |> length == 1
    end
  end

  def seeds(_context) do
    [
      %{name: "Bank", type: Account.type_by_key(:cash)},
      %{name: "Receivable", type: Account.type_by_key(:receivable)},
      %{name: "Payable", type: Account.type_by_key(:payable)}
    ]
    |> Enum.map(&Conty.create_account/1)

    :ok
  end
end
