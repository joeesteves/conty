defmodule ContyTest do
  use ExUnit.Case
  import TestHelper

  alias Conty.{Entry}

  setup_all do
    {:ok, account} = Conty.create_account(%{name: "Test Account"})

    [account: account]
  end

  test "unbalanced Entry is invalid", context do
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
    assert Enum.join(errors_on(changeset).base) =~ ~r/not balanced/
  end

  test "balanced Entry", context do
    changeset =
      %Entry{}
      |> Entry.changeset(%{
        date: Date.utc_today(),
        entry_items: [
          %{amount: 100, account_id: context[:account].id},
          %{amount: -100, account_id: context[:account].id}
        ]
      })

    assert not (Enum.join(errors_on(changeset)[:base] || [], "") =~ ~r/not balanced/)
  end

  describe "delete_account" do
    test "ensure there are no associated items", context do
      {:ok, entry} =
        Conty.create_entry(%{
          date: Date.utc_today(),
          entry_items: [
            %{amount: 100, account_id: context[:account].id},
            %{amount: -100, account_id: context[:account].id}
          ]
        })

      assert {:error, changeset} = Conty.delete_account(context[:account])
      assert "are still associated with this entry" in errors_on(changeset)[:entry_items]
    end
  end
end
