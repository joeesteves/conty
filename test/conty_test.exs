defmodule ContyTest do
  use ExUnit.Case
  doctest Conty
  alias Conty.{Entry, EntryItem}

  test "Entry should be balance" do
    changeset = %Entry{}
    |> Entry.changeset(%{
      date: Date.utc_today(),
      entry_items: [
        %{amount: 100},
        %{amount: -10}
      ]
    })

    assert not changeset.valid?

  end
end
