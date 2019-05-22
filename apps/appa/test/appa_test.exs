defmodule AppaTest do
  use ExUnit.Case
  doctest Appa

  test "greets the world" do
    assert Appa.hello() == :world
  end
end
