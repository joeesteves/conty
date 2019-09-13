defmodule ContyTest do
  use ExUnit.Case
  doctest Conty

  test "greets the world" do
    assert Conty.hello() == :world
  end
end
