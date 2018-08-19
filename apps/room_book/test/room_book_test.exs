defmodule RoomBookTest do
  use ExUnit.Case
  doctest RoomBook

  test "greets the world" do
    assert RoomBook.hello() == :world
  end
end
