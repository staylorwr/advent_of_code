defmodule Aoc.Year2022.Day12.HillClimbingAlgorithmTest do
  use Aoc.DayCase, async: true
  doctest Aoc.Year2022.Day12.HillClimbingAlgorithm, import: true

  alias Aoc.Year2022.Day12.HillClimbingAlgorithm, as: Day12

  @example """
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  """

  describe "part_1/1" do
    test "examples" do
      assert Day12.part_1(@example) == 31
    end

    @tag day: 12, year: 2022
    test "input", %{input: input} do
      assert input |> Day12.part_1() == 528
    end
  end

  describe "part_2/1" do
    test "examples" do
      assert Day12.part_2(@example) == 29
    end

    @tag day: 12, year: 2022
    test "input", %{input: input} do
      assert input |> Day12.part_2() == 1
    end
  end
end
