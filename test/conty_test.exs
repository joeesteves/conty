defmodule ContyTest do
  use ExUnit.Case
  import TestHelper

  alias Conty.{Entry}

  test "Entry validate balance" do
    changeset =
      %Entry{}
      |> Entry.changeset(%{
        date: Date.utc_today(),
        entry_items: [
          %{amount: 100},
          %{amount: -10}
        ]
      })


    assert not changeset.valid?
    assert "not balanced" in errors_on(changeset).base
  end
end
