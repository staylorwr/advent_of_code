defmodule Aoc.Year2021.Day05.HydrothermalVentureTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2021.Day05.HydrothermalVenture, import: true

  alias Aoc.Year2021.Day05.HydrothermalVenture, as: Day05

  @example """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "part_1/1" do
    test "examples" do
      assert Day05.part_1(@example) == 5
    end

    @tag day: 05, year: 2021
    test "input", %{input: input} do
      assert input |> Day05.part_1() == 7674
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day05.part_2(@example) == 12
    end

    @tag day: 05, year: 2021
    test "input", %{input: input} do
      assert input |> Day05.part_2() == 20898
    end
  end
end
