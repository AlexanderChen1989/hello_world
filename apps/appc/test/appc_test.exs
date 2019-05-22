defmodule AppcTest do
  use ExUnit.Case
  doctest Appc

  test "greets the world" do
    assert Appc.hello() == :world
  end
end
