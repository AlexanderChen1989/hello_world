defmodule AppbTest do
  use ExUnit.Case
  doctest Appb

  test "greets the world" do
    assert Appb.hello() == :world
  end
end
