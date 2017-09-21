defmodule PublicSuffexTest do
  use ExUnit.Case
  doctest PublicSuffex

  test "parse should find the longest matching tld" do
    assert PublicSuffex.parse("thing.ivano-frankivsk.ua") == "ivano-frankivsk.ua"
  end

  test "parse should find the longest matching tld again" do
    assert PublicSuffex.parse("thing.com.so") == "com.so"
  end 

  test "parse should be fast" do
    {time, _} = :timer.tc(fn -> PublicSuffex.parse("thing.com.so") end)
    assert time <= 10000 # microseconds
  end

  test "parse should be repeatedly fast" do
    result = 1..100_000
      |> Enum.map(fn _ -> 
        :timer.tc(fn -> PublicSuffex.parse("thing.com.so") end)
        |> elem(0)
      end)
      |> Enum.sum
    assert result <= 1_000_000 # milliseconds
  end


end
