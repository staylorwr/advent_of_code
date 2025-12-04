defmodule Aoc.Year2025.Day04.PrintingDepartmentTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2025.Day04.PrintingDepartment, import: true

  alias Aoc.Year2025.Day04.PrintingDepartment, as: Day04

  @example """
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  describe "part_1/1" do
    test "examples" do
      assert Day04.part_1(@example) == 13
    end

    @tag day: 04, year: 2025
    test "input", %{input: input} do
      assert input |> Day04.part_1() == 1480
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day04.part_2(@example) == 43
    end

    @tag day: 04, year: 2025
    test "input", %{input: input} do
      assert input |> Day04.part_2() == 8899
    end
  end
end
