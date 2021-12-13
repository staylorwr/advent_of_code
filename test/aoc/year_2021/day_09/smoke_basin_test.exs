defmodule Aoc.Year2021.Day09.SmokeBasinTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day09.SmokeBasin, import: true

  alias Aoc.Year2021.Day09.SmokeBasin, as: Day09

  @example """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  describe "part_1/1" do
    test "examples" do
      assert Day09.part_1(@example) == 15
    end

    @tag day: 09, year: 2021
    test "input", %{input: input} do
      assert input |> Day09.part_1() == 475
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day09.part_2(@example) == 1134
    end

    @tag day: 09, year: 2021
    test "input", %{input: input} do
      assert input |> Day09.part_2() == 1_092_012
    end
  end
end
