defmodule ContyTest do
  use ExUnit.Case
  import TestHelper

  alias Conty.{Entry}

  setup_all do
    {:ok, account} = Conty.create_account(%{name: "Test Account"})

    [account: account]
  end

  test "Entry not balanced is invalid", context do
    changeset =
      %Entry{}
      |> Entry.changeset(%{
        date: Date.utc_today(),
        entry_items: [
          %{amount: 100, account_id: context[:account].id},
          %{amount: -10, account_id: context[:account].id}
        ]
      })


    assert not changeset.valid?
    assert "not balanced" in errors_on(changeset).base
  end

  test "Entry balanced", context do
    changeset =
      %Entry{}
      |> Entry.changeset(%{
        date: Date.utc_today(),
        entry_items: [
          %{amount: 100, account_id: context[:account].id},
          %{amount: -100, account_id: context[:account].id}
        ]
      })


    assert "not balanced" not in (errors_on(changeset)[:base] || [])
  end
end
