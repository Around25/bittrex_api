defmodule BittrexApiTest do
  use ExUnit.Case
  doctest BittrexApi

  test "greets the world" do
    assert BittrexApi.hello() == :world
  end
end
