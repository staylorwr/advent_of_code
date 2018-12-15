defmodule Aoc.Year2018.Day15.BeverageBanditsTest do
  use Aoc.DayCase
  doctest Aoc.Year2018.Day15.BeverageBandits, import: true

  alias Aoc.Year2018.Day15.BeverageBandits

  describe "part_1/1" do
    test "examples" do
      input = """
      #########
      #G......#
      #.E.#...#
      #..##..G#
      #...##..#
      #...#...#
      #.G...G.#
      #.....G.#
      #########
      """

      assert BeverageBandits.part_1(input) == 18740
    end

    @tag day: 15, year: 2018
    test "input", %{input: input} do
      assert input |> BeverageBandits.part_1() == input
    end
  end

  describe "part_2/1" do
    test "examples" do
    end

    @tag day: 15, year: 2018
    test "input", %{input: input} do
      assert input |> BeverageBandits.part_2() == input
    end
  end
end
