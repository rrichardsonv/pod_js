defmodule PodJsTest do
  use ExUnit.Case
  doctest PodJs

  test "greets the world" do
    assert PodJs.hello() == :world
  end
end
