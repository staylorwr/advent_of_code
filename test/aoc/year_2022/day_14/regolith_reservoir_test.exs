defmodule Aoc.Year2022.Day14.RegolithReservoirTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day14.RegolithReservoir, import: true

  alias Aoc.Year2022.Day14.RegolithReservoir, as: Day14

  @example """
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
  """

  describe "part_1/1" do
    test "examples" do
      assert Day14.part_1(@example) == 24
    end

    @tag day: 14, year: 2022
    test "input", %{input: input} do
      assert input |> Day14.part_1() == 817
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day14.part_2(@example) == 93
    end

    @tag day: 14, year: 2022
    test "input", %{input: input} do
      assert input |> Day14.part_2() == 23416
    end
  end
end
