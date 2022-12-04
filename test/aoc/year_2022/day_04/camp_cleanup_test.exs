defmodule Aoc.Year2022.Day04.CampCleanupTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day04.CampCleanup, import: true

  alias Aoc.Year2022.Day04.CampCleanup, as: Day04

  @example """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  describe "part_1/1" do
    test "examples" do
      assert Day04.part_1(@example) == 2
    end

    @tag day: 04, year: 2022
    test "input", %{input: input} do
      assert input |> Day04.part_1() == 605
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 04, year: 2022
    test "input", %{input: input} do
      assert input |> Day04.part_2() == input
    end
  end
end
