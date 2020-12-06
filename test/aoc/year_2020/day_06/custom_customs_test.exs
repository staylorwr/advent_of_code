defmodule Aoc.Year2020.Day06.CustomCustomsTest do
  use Aoc.DayCase
  doctest Aoc.Year2020.Day06.CustomCustoms, import: true

  alias Aoc.Year2020.Day06.CustomCustoms, as: Day06

  @example """
  abc

  a
  b
  c

  ab
  ac

  a
  a
  a
  a

  b
  """

  describe "part_1/1" do
    test "examples" do
      assert Day06.part_1(@example) == 11
    end

    @tag day: 06, year: 2020
    test "input", %{input: input} do
      assert input |> Day06.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day06.part_2(@example) == 6
    end

    @tag day: 06, year: 2020
    test "input", %{input: input} do
      assert input |> Day06.part_2() == input
    end
  end
end
