defmodule Aoc.Year2022.Day08.TreetopTreeHouseTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day08.TreetopTreeHouse, import: true

  alias Aoc.Year2022.Day08.TreetopTreeHouse, as: Day08

  @example """
  30373
  25512
  65332
  33549
  35390
  """

  describe "part_1/1" do
    test "examples" do
      assert Day08.part_1(@example) == 21
    end

    @tag day: 08, year: 2022
    test "input", %{input: input} do
      assert input |> Day08.part_1() == 1679
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 08, year: 2022
    test "input", %{input: input} do
      assert input |> Day08.part_2() == input
    end
  end
end
